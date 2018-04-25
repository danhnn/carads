/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';
const factory = getFactory();

const NS = 'org.carads';
const ACC_NS = 'Account'
const ADS_NS = 'Ads'
const ADS_CONTRACT_NS = 'AdsContract'
const ADS_PREP_TRANS_NS = 'AdsPreparationDeposit'
const ADS_DRV_SUPP_DEP_TRANS_NS = 'ExecutionDepositSupplierAndDriver'
const ADS_EXEC_DEP_TRANS_NS = 'ExecutionDeposit'
const ESCROW_CONTRACT_NS= 'EscrowContract'

const ACC_ASSET_REG = NS+'.'+ACC_NS
const ADS_ASSET_REG = NS+'.'+ADS_NS
const ADS_CONTRACT_ASSET_REG = NS+'.'+ADS_CONTRACT_NS
const ADS_PREP_TRANS_REG = NS+'.'+ADS_PREP_TRANS_NS
const ADS_EXEC_DEP_REG = NS+'.'+ADS_EXEC_DEP_TRANS_NS
const ESCROW_CONTRACT_REG = NS+'.'+ESCROW_CONTRACT_NS


function makeid() {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for (var i = 0; i < 5; i++)
    text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}


/**
 * AccountTransfer - execution deposit
 * @param {org.carads.ExecutionDeposit} accountTransfer
 * @transaction
 */
async function executionDeposit(accountTransfer) {
  if(accountTransfer.client.balance < accountTransfer.clientValue) {
    throw new Error("driver insufficient funds")
  }
  if(accountTransfer.supplier.balance < accountTransfer.supplierValue) {
    throw new Error("supplier insufficient funds")
  }
  accountTransfer.client.balance -= accountTransfer.clientValue
  accountTransfer.supplier.balance -= accountTransfer.supplierValue
  accountTransfer.contract += accountTransfer.clientValue + accountTransfer.supplierValue

  const consumerRegistryClient = await getAssetRegistry(ACC_ASSET_REG)
  await consumerRegistryClient.update(accountTransfer.client)
  await consumerRegistryClient.update(accountTransfer.supplier)
  await consumerRegistryClient.update(accountTransfer.contract)
}


/**
 * AccountTransfer - driver and supplier deposit
 * @param {org.carads.ExecutionDepositSupplierAndDriver} accountTransfer
 * @transaction
 */
async function executionDepositSupplierAndDriver(accountTransfer) {
  if(accountTransfer.driver.balance < accountTransfer.driverValue) {
    throw new Error("driver insufficient funds")
  }
  if(accountTransfer.supplier.balance < accountTransfer.supplierValue) {
    throw new Error("supplier insufficient funds")
  }
  accountTransfer.driver.balance -= accountTransfer.driverValue
  accountTransfer.supplier.balance -= accountTransfer.supplierValue
  accountTransfer.contract += accountTransfer.driverValue + accountTransfer.supplierValue

  const consumerRegistryClient = await getAssetRegistry(ACC_ASSET_REG)
  await consumerRegistryClient.update(accountTransfer.driver)
  await consumerRegistryClient.update(accountTransfer.supplier)
  await consumerRegistryClient.update(accountTransfer.contract)
}

/**
 * AccountTransfer - move money from accounts
 * @param {org.carads.AdsPreparationDeposit} accountTransfer
 * @transaction
 */
async function AdsPreparationDeposit(accountTransfer) {
  if(accountTransfer.owner.balance < accountTransfer.value) {
      throw new Error("insufficient funds")
  }

  accountTransfer.owner.balance -= accountTransfer.value
  accountTransfer.supplier.balance += accountTransfer.value

  const consumerRegistryClient = await getAssetRegistry(ACC_ASSET_REG)
  await consumerRegistryClient.update(accountTransfer.owner)
  await consumerRegistryClient.update(accountTransfer.supplier)
}

/**
 * Ads - Client create an Ads
 * @param {org.carads.Consumer} client
 *
 */
async function createAds(client, data){
  var ads = factory.newResource(NS, ADS_NS, makeid());
  ads.owner = client;
  ads.description = data.description;
  ads.bannerUrl = data.bannerUrl;
  ads.fromDate = data.fromDate;
  ads.kickOffDate = data.kickOffDate;
  ads.toDate = data.toDate;
  ads.area = data.area;
  ads.minNumberOfCar = data.minNumberOfCar;
  ads.maxNumberOfCar = data.maxNumberOfCar;
  ads.travelDistance = data.travelDistance;
  ads.price = data.price;
  const adsRegistryClient = await getAssetRegistry(ADS_ASSET_REG);
  await adsRegistryClient.add(ads);
  return ads.adsId
}

/**
 * Get list of available Ads
 * @param {org.carads.Consumer} consumer
 * @return {org.carads.Ads} ads
 */
async function getAds(consumer){
  const adsRegistryClient = await getAssetRegistry(ADS_ASSET_REG);
  var allAds = await adsRegistryClient.getAll()
  if (consumer.type == 'client' || consumer.type == 'supplier') {
    return allAds
  } else { // Only return accepted Ads to driver
    allAds.filter(ads => ads.contract !== null);
    return allAds
  }
}

/**
 * Get list of available Ads
 * @param {org.carads.Consumer} consumer
 * @return {org.carads.Ads} ads
 */
async function getAdById(adsId){
  const adsRegistryClient = await getAssetRegistry(ADS_ASSET_REG);
  var allAds = await adsRegistryClient.getAll()
  const result = allAds.filter(ads => ads.adsId == adsId);
  return result.first
  //Consumer
}

/**
 * Supplier accept Ads of Client, Escrow contract will be created,
 * depsosit will be transfered from Client's account to Supplier's account.
 * @param {org.carads.Consumer} supplier
 * @param {org.carads.Ads} ads
 * @return {org.carads.AdsContract} adsContract
 */
async function supplierAcceptAds(supplier, ads, data){
  //Create AdsContract
  var adsContract = factory.newResource(NS, ADS_CONTRACT_NS, makeid());
  adsContract.supplier = supplier
  //Create EscrowContract
  var adsPrepDepositContract = factory.newResource(NS, ADS_PREP_TRANS_REG);
  adsPrepDepositContract.owner = ads.owner
  adsPrepDepositContract.supplier = supplier
  adsPrepDepositContract.value = ads.price * 0.3  // 30% of the contract
  //Make transaction
  AdsPreparationDeposit(adsPrepDepositContract)
  //Update depositTx to AdsContract
  adsContract.depositTx = adsPrepDepositContract.transactionId
  var adsRegistryClient = await getAssetRegistry(ADS_ASSET_REG)
  await adsRegistryClient.add(adsContract);
  //return AdsContract
  return adsContract
}


/**
 * Driver accept Ads, Escrow contract will be created,
 * depsosit will be transfered from Driver's account to Contract's Balance,
 * from Supplier's account to Contract's Balance.
 * @param {org.carads.Consumer} driver
 * @param {org.carads.Ads} ads
 */
async function driverAcceptAds(driver, ads){
  // Create Escrow contract
  var execDepositSupplierAndDriver = factory.newResource(NS, ADS_DRV_SUPP_DEP_TRANS_NS);
  var escrowContract = factory.newResource(NS, ESCROW_CONTRACT_NS)
  var adsContractRegistryClient = await getAssetRegistry(ADS_CONTRACT_ASSET_REG)
  execDepositSupplierAndDriver.driver = driver
  execDepositSupplierAndDriver.supplier = ads.contract.supplier
  execDepositSupplierAndDriver.escrowContract = escrowContract
  execDepositSupplierAndDriver.driverValue = ads.price * 0.1
  execDepositSupplierAndDriver.supplierValue = ads.price / ads.maxNumberOfCar
  // driver desposit to contract balance
  // query supplier from adsContract of Ads
  // supplier deposit to contract balance
  // Update driverSupplierTx list of adsContract of Ads
  executionDepositSupplierAndDriver(execDepositSupplierAndDriver)
  ads.adsContract.driverSupplierTx.push(executionDepositSupplierAndDriver.transactionId)
  await adsContractRegistryClient.update(ads.adsContract);
  // Check if driverSupplierTx has reached minNumberOfCar to change to Execution Phase
  if (ads.adsContract.driverSupplierTx.length == ads.minNumberOfCar) {
    runAds(ads)
  }
}

/**
 * Kickoff Execution Phase of Ads
 * @param {org.carads.Ads} ads
 */
async function runAds(ads){
  // Create Escrow contract between Client and Supplier
  var escrowContract = factory.newResource(NS, ESCROW_CONTRACT_NS)
  var execDeposit = factory.newResource(NS, ADS_EXEC_DEP_TRANS_NS)
  execDeposit.supplier = ads.adsContract.supplier
  execDeposit.client = ads.client
  execDeposit.supplierValue = ads.price * 0.1
  execDeposit.clientValue = ads.price * 0.7
  // Supplier deposit to contract balance 10% payment of Ads
  // query supplier from adsContract of Ads
  // supplier deposit to contract balance
  executionDeposit(execDeposit)
  ads.adsContract.executionTx = execDeposit.transactionId
  var adsContractRegistryClient = await getAssetRegistry(ADS_CONTRACT_ASSET_REG)
  adsContractRegistryClient.update(ads.adsContract)
}




