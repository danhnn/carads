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

  const consumerRegistryClient = await getAssetRegistry("org.carads.Account")
  await consumerRegistryClient.update(accountTransfer.owner)
  await consumerRegistryClient.update(accountTransfer.supplier)
}

/**
 * Ads - Client create an Ads
 * @param {org.carads.Consumer} client
 * 
 */
async function createAds(client){
  var factory = getFactory();
  var NS = 'org.carads';
  var ads = factory.newResource(NS,'Ads','ads1');
  ads.owner = client;
  ads.description = 'Something something';
  ads.bannerUrl = 'banner.jpg';
  ads.fromDate = '2017-04-05';
  ads.kickOffDate = '2017-04-05';
  ads.toDate = '2017-04-05';
  ads.area = 'HCM City';
  ads.minNumberOfCar = 10;
  ads.maxNumberOfCar = 20;
  ads.travelDistance = 2100;
  ads.price = 50000000;
  const adsRegistryClient = await getAssetRegistry('org.carads.Ads');
  await adsRegistryClient.add(ads);
}

/**
 * Get list of available Ads
 * @param {org.carads.Consumer} consumer
 * @return {org.carads.Ads} ads
 */
async function getAds(consumer){
  const adsRegistryClient = await getAssetRegistry('org.carads.Ads');
  var allAds = await adsRegistryClient.getAll()
  const result = allAds.filter(ads => ads.adsId == '');
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
async function supplierAcceptAds(supplier,ads){
  //Create AdsContract
  //Create EscrowContract
  //Make transaction 
  //Update depositTx to AdsContract
  //return AdsContract
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
  // driver desposit to contract balance
  // query supplier from adsContract of Ads
  // supplier deposit to contract balance
  // Update driverSupplierTx list of adsContract of Ads
  // Check if driverSupplierTx has reached minNumberOfCar to change to Execution Phase
}

/**
 * Kickoff Execution Phase of Ads
 * @param {org.carads.Ads} ad
 */
async function runAds(ad){
  // Create Escrow contract between Client and Supplier
  // Supplier deposit to contract balance 10% payment of Ads
  // query supplier from adsContract of Ads
  // supplier deposit to contract balance
  // Update driverSupplierTx list of adsContract of Ads
  // Check if driverSupplierTx has reached minNumberOfCar to change to Execution Phase
}




