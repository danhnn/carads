Feature: sample

  Background:
    Given I have deployed the business network definition ..
    And I have added the following participants of type org.carads.Consumer
      | consumerId                           | email                  | company  | name             | nationalCardImage | nationalId | type     |
      | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | pandg@email.com        | P&G      | Nguyễn Ngọc Danh | 130592309.jpg     | 130592309  | client   |
      | 5c6748ec-45f5-11e8-842f-0ed5f89f718b | unilever@email.com     | unilever | Nguyễn Ngọc B    | 130592569.jpg     | 130592569  | client   |
      | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | grab@email.com         | Grab     | Phạm Công Danh   | 260592309.jpg     | 260592309  | supplier |
      | 76bd1ed8-45f5-11e8-842f-0ed5f89f718b | carads@email.com       | CarAds   | Đinh La Thăng    | 270592569.jpg     | 270592569  | supplier |
      | 895af98e-45f5-11e8-842f-0ed5f89f718b | hoangtiendat@email.com | 1        | Hoàng Tiến Đạt   | 260692309.jpg     | 260692309  | driver   |
      | 895afc4a-45f5-11e8-842f-0ed5f89f718b | hariwon@email.com      | 2        | Hariwon          | 260692509.jpg     | 260692509  | driver   |
    And I have added the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 1         | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | 200000000 |
      | 2         | 5c6748ec-45f5-11e8-842f-0ed5f89f718b | 600000000 |
      | 3         | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | 100000000 |
      | 4         | 76bd1ed8-45f5-11e8-842f-0ed5f89f718b | 200000000 |
      | 5         | 895af98e-45f5-11e8-842f-0ed5f89f718b | 2000000   |
      | 6         | 895afc4a-45f5-11e8-842f-0ed5f89f718b | 3000000   |
    And I have added the following assets of type org.carads.Car
      | carId | model               | plateNumber  | owner                                |
      | 1     | Innova 2017 version | 51F - 255.11 | 895af98e-45f5-11e8-842f-0ed5f89f718b |
      | 2     | Porsche Cayenne GTS | 51F - 999.99 | 895afc4a-45f5-11e8-842f-0ed5f89f718b |

    And I have issued the participant org.carads.Consumer#5c6745b8-45f5-11e8-842f-0ed5f89f718b with the identity ClientPg
    And I have issued the participant org.carads.Consumer#5c6748ec-45f5-11e8-842f-0ed5f89f718b with the identity ClientUni
    And I have issued the participant org.carads.Consumer#76bd1c3a-45f5-11e8-842f-0ed5f89f718b with the identity SupplierGrab
    And I have issued the participant org.carads.Consumer#895af98e-45f5-11e8-842f-0ed5f89f718b with the identity DriverDat
    And I have issued the participant org.carads.Consumer#895afc4a-45f5-11e8-842f-0ed5f89f718b with the identity DriverHari

  # Scenario: Create ads and view permission
  #     When I use the identity ClientPg
  #     And I add the following asset of type org.carads.Ads
  #         | adsId | owner | contract | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
  #         | 57934d92-45f6-11e8-842f-0ed5f89f718b |5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
  #     Then I should have the following assets of type org.carads.Ads
  #         | adsId | owner | contract | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
  #         | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
  #     And I use the identity SupplierGrab
  #     Then I should have the following assets of type org.carads.Ads
  #         | adsId | owner | contract | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
  #         | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
  #     And I use the identity DriverHari
  #     Then I should have the following assets of type org.carads.Ads
  #         | adsId | owner | contract | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
  #         | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |

  #  Scenario: client pg can deposit money to supplier grab
  #     When I use the identity ClientPg
  #     And I submit the following transaction of type org.carads.AdsPreparationDeposit
  #         | owner | supplier | value |
  #         | 1    | 3  | 50000000 |
  #     And I should have the following assets of type org.carads.Account
  #         | accountId | owner           | balance |
  #         | 1         | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | 150000000      |
  #     And I use the identity SupplierGrab
  #     Then I should have the following assets of type org.carads.Account
  #         | accountId | owner           | balance |
  #         | 3         | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | 150000000      |

  Scenario: Full Scenario
    When I use the identity ClientPg
    And I add the following asset of type org.carads.Ads
      | adsId                                | owner                                | contract  | description           | bannerUrl       | fromDate   | kickOffDate | toDate     | area           | minNumberOfCar | maxNumberOfCar | travelDistance | price   |
      | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18  | 2017-07-01 | Hochiminh city | 2              | 2              | 2100           | 5000000 |
    Then I should have the following assets of type org.carads.Ads
      | adsId                                | owner                                | contract  | description           | bannerUrl       | fromDate   | kickOffDate | toDate     | area           | minNumberOfCar | maxNumberOfCar | travelDistance | price   |
      | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18  | 2017-07-01 | Hochiminh city | 2              | 2              | 2100           | 5000000 |
    And I use the identity SupplierGrab
    Then I should have the following assets of type org.carads.Ads
      | adsId                                | owner                                | contract  | description           | bannerUrl       | fromDate   | kickOffDate | toDate     | area           | minNumberOfCar | maxNumberOfCar | travelDistance | price   |
      | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18  | 2017-07-01 | Hochiminh city | 2              | 2              | 2100           | 5000000 |
    And I use the identity DriverHari
    Then I should have the following assets of type org.carads.Ads
      | adsId                                | owner                                | contract  | description           | bannerUrl       | fromDate   | kickOffDate | toDate     | area           | minNumberOfCar | maxNumberOfCar | travelDistance | price   |
      | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | contracId | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18  | 2017-07-01 | Hochiminh city | 2              | 2              | 2100           | 5000000 |
    And I use the identity SupplierGrab
    Then I add the following asset
      """
      {"$class":"org.carads.AdsContract", "adsContractId":"894c5358-4833-11e8-842f-0ed5f89f718b", "expireDate":"2017-05-13", "supplier":"76bd1c3a-45f5-11e8-842f-0ed5f89f718b", "depositTx":"depositTx","driverSupplierTx":["tx1","tx2"],"ExecutionTx":"ExecutionTx"}
      """
    And I use the identity ClientPg
    Then I submit the following transaction of type org.carads.AdsPreparationDeposit
      | owner | supplier | value   |
      | 1     | 3        | 1500000 |
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 1         | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | 198500000 |
    And I use the identity SupplierGrab
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 3         | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | 101500000 |
    Then I update the following asset
      """
      {"$class":"org.carads.AdsContract", "adsContractId":"894c5358-4833-11e8-842f-0ed5f89f718b", "expireDate":"2017-05-13", "supplier":"76bd1c3a-45f5-11e8-842f-0ed5f89f718b", "depositTx":"9b94eb98-4841-11e8-842f-0ed5f89f718b","driverSupplierTx":["tx1","tx2"],"ExecutionTx":"ExecutionTx"}
      """
    Then I should have the following asset
      """
      {"$class":"org.carads.AdsContract", "adsContractId":"894c5358-4833-11e8-842f-0ed5f89f718b", "expireDate":"2017-05-13", "supplier":"76bd1c3a-45f5-11e8-842f-0ed5f89f718b", "depositTx":"9b94eb98-4841-11e8-842f-0ed5f89f718b","driverSupplierTx":["tx1","tx2"],"ExecutionTx":"ExecutionTx"}
      """
    And I use the identity SupplierGrab
    And I add the following asset of type org.carads.EscrowContract
      | contractId                           | balance |
      | 7e0b9846-4847-11e8-842f-0ed5f89f718b | 0       |
    Then I submit the following transaction of type org.carads.ExecutionDepositSupplierAndDriver
      | driver | supplier | contract                             | driverValueue | supplierValue |
      | 5      | 3        | 7e0b9846-4847-11e8-842f-0ed5f89f718b | 500000        | 5000000       |
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 3         | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | 198500000 |
    And I use the identity DriverDat
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 5         | 895af98e-45f5-11e8-842f-0ed5f89f718b | 101500000 |
    And I use the identity SupplierGrab
    And I add the following asset of type org.carads.EscrowContract
      | contractId                           | balance |
      | 72ce6e06-4847-11e8-842f-0ed5f89f718b | 0       |
    Then I submit the following transaction of type org.carads.ExecutionDepositSupplierAndDriver
      | driver | supplier | contract                             | driverValueue | supplierValue |
      | 6      | 3        | 72ce6e06-4847-11e8-842f-0ed5f89f718b | 500000        | 5000000       |
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 3         | 72ce6e06-45f5-11e8-842f-0ed5f89f718b | 198500000 |
    And I use the identity DriverDat
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 6         | 895afc4a-45f5-11e8-842f-0ed5f89f718b | 101500000 |
    And I use the identity SupplierGrab
    Then I update the following asset
      """
      {"$class":"org.carads.AdsContract", "adsContractId":"894c5358-4833-11e8-842f-0ed5f89f718b", "expireDate":"2017-05-13", "supplier":"76bd1c3a-45f5-11e8-842f-0ed5f89f718b", "depositTx":"9b94eb98-4841-11e8-842f-0ed5f89f718b","driverSupplierTx":["b161b236-484a-11e8-842f-0ed5f89f718b","b8ec0538-484a-11e8-842f-0ed5f89f718b"],"ExecutionTx":"ExecutionTx"}
      """
    And I add the following asset of type org.carads.EscrowContract
      | contractId                           | balance |
      | f70da95c-484a-11e8-842f-0ed5f89f718b | 0       |
    Then I submit the following transaction of type org.carads.ExecutionDeposit
      | client | supplier | contract                             | supplierValue | clientValue |
      | 1      | 3        | f70da95c-484a-11e8-842f-0ed5f89f718b | 500000        | 3500000     |
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 3         | 72ce6e06-45f5-11e8-842f-0ed5f89f718b | 101500000 |
    And I use the identity ClientPg
    Then I should have the following assets of type org.carads.Account
      | accountId | owner                                | balance   |
      | 1         | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | 101500000 |
    Then I update the following asset
      """
      {"$class":"org.carads.AdsContract", "adsContractId":"894c5358-4833-11e8-842f-0ed5f89f718b", "expireDate":"2017-05-13", "supplier":"76bd1c3a-45f5-11e8-842f-0ed5f89f718b", "depositTx":"9b94eb98-4841-11e8-842f-0ed5f89f718b","driverSupplierTx":["b161b236-484a-11e8-842f-0ed5f89f718b","b8ec0538-484a-11e8-842f-0ed5f89f718b"],"ExecutionTx":"aad6b762-484b-11e8-842f-0ed5f89f718b"}





