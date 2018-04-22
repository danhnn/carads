Feature: sample

    Background:
        Given I have deployed the business network definition ..
        And I have added the following participants of type org.carads.Consumer
            | clientId | email | company | name | nationalCardImage | nationalId | type |
            | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | pandg@email.com | P&G | Nguyễn Ngọc Danh | 130592309.jpg | 130592309 | client |
            | 5c6748ec-45f5-11e8-842f-0ed5f89f718b | unilever@email.com | unilever | Nguyễn Ngọc B | 130592569.jpg | 130592569 | client |
            | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | grab@email.com | Grab | Phạm Công Danh | 260592309.jpg | 260592309 | supplier |
            | 76bd1ed8-45f5-11e8-842f-0ed5f89f718b | carads@email.com | CarAds | Đinh La Thăng | 270592569.jpg | 270592569 | supplier |
            | 895af98e-45f5-11e8-842f-0ed5f89f718b | hoangtiendat@email.com | 1 | Hoàng Tiến Đạt | 260692309.jpg | 260692309 | driver |
            | 895afc4a-45f5-11e8-842f-0ed5f89f718b | hariwon@email.com | 2 | Hariwon | 260692509.jpg | 260692509 | driver |
         And I have added the following assets of type org.carads.Account
            | accountId | owner           | balance |
            | 1         | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | 200000000      |
            | 2         | 5c6748ec-45f5-11e8-842f-0ed5f89f718b | 600000000      |
            | 3         | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | 100000000      |
            | 4         | 76bd1ed8-45f5-11e8-842f-0ed5f89f718b | 200000000      |
            | 5         | 895af98e-45f5-11e8-842f-0ed5f89f718b | 2000000      |
            | 6         | 895afc4a-45f5-11e8-842f-0ed5f89f718b | 3000000      |
        And I have added the following assets of type org.carads.Car
            | carId | model | plateNumber | owner |
            | 1 | Innova 2017 version | 51F - 255.11 | 895af98e-45f5-11e8-842f-0ed5f89f718b |
            | 2 | Porsche Cayenne GTS | 51F - 999.99 | 895afc4a-45f5-11e8-842f-0ed5f89f718b |
        And I have added the following assets of type org.carads.Ads
            | adsId | owner | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
            | 57934d93-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |

        And I have issued the participant org.carads.Consumer#5c6745b8-45f5-11e8-842f-0ed5f89f718b with the identity ClientPg
        And I have issued the participant org.carads.Consumer#5c6748ec-45f5-11e8-842f-0ed5f89f718b with the identity ClientUni
        And I have issued the participant org.carads.Consumer#76bd1c3a-45f5-11e8-842f-0ed5f89f718b with the identity SupplierGrab
        And I have issued the participant org.carads.Consumer#895af98e-45f5-11e8-842f-0ed5f89f718b with the identity DriverDat
        And I have issued the participant org.carads.Consumer#895afc4a-45f5-11e8-842f-0ed5f89f718b with the identity DriverHari

    Scenario: Create ads and view permission
        When I use the identity ClientPg
        And I add the following asset of type org.carads.Ads
            | adsId | owner | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
            | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
        Then I should have the following assets of type org.carads.Ads
            | adsId | owner | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
            | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
        And I use the identity ClientUni
        Then I should have the following assets of type org.carads.Ads
            | adsId | owner | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
            | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
         Then I should get an error matching /Object with ID '57934d92-45f6-11e8-842f-0ed5f89f718b' in collection with ID 'Asset:org.carads.Ads' does not exist/
         And I use the identity grab
         Then I should have the following assets of type org.carads.Ads
            | adsId | owner | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
            | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |

     Scenario: client pg can deposit money to supplier grab
        When I use the identity ClientPg
        And I submit the following transaction of type org.carads.AdsPreparationDeposit
            | owner | supplier | value |
            | 5c6745b8-45f5-11e8-842f-0ed5f89f718b    | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b  | 50000000 |
        And I should have the following assets of type org.carads.Consumer
            | accountId | owner           | balance |
            | 1         | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | 250000000      |
        And I use the identity SupplierGrab
        Then I should have the following assets of type org.carads.Consumer
            | accountId | owner           | balance |
            | 1         | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | 150000000      |

