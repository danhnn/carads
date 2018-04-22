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

  const consumerRegistryClient = await getAssetRegistry("org.carads.Consumer")
  await consumerRegistryClient.update(accountTransfer.owner)
  await consumerRegistryClient.update(accountTransfer.supplier)
}