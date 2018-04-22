Feature: Test

    Background:
        Given I have deployed the business network definition ..
        And I have added the following participants of type org.carads.Client
            | clientId | email | company | name | nationalCardImage | nationalId | balance |
            | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | pandg@email.com | P&G | Nguyễn Ngọc Danh | 130592309.jpg | 130592309 | 200000000 |
            | 5c6748ec-45f5-11e8-842f-0ed5f89f718b | unilever@email.com | unilever | Nguyễn Ngọc B | 130592569.jpg | 130592569 | 600000000 |
        And I have added the following assets of type org.carads.Supplier
            | supplierId | email | company | name | nationalCardImage | nationalId | balance |
            | 76bd1c3a-45f5-11e8-842f-0ed5f89f718b | grab@email.com | Grab | Phạm Công Danh | 260592309.jpg | 260592309 | 100000000 |
            | 76bd1ed8-45f5-11e8-842f-0ed5f89f718b | carads@email.com | CarAds | Đinh La Thăng | 270592569.jpg | 270592569 | 200000000 |
        And I have added the following assets of type org.carads.Driver
            | driverId | email | car | name | nationalCardImage | nationalId | balance |
            | 895af98e-45f5-11e8-842f-0ed5f89f718b | hoangtiendat@email.com | 1 | Hoàng Tiến Đạt | 260692309.jpg | 260692309 | 2000000 |
            | 895afc4a-45f5-11e8-842f-0ed5f89f718b | hariwon@email.com | 2 | Hariwon | 260692509.jpg | 260692509 | 3000000 |
        And I have added the following assets of type org.carads.Car
            | carId | model | plateNumber | 
            | 1 | Innova 2017 version | 51F - 255.11 | 
            | 2 | Porsche Cayenne GTS | 51F - 999.99 |
        And I have issued the participant org.carads.Client#5c6745b8-45f5-11e8-842f-0ed5f89f718b with the identity pg
        And I have issued the participant org.carads.Supplier#76bd1c3a-45f5-11e8-842f-0ed5f89f718b with the identity grab
        And I have issued the participant org.carads.Driver#895af98e-45f5-11e8-842f-0ed5f89f718b with the identity dat
        And I have issued the participant org.carads.Driver#895afc4a-45f5-11e8-842f-0ed5f89f718b with the identity hari

    Scenario: pg can create 
        When I use the identity pg
        And I should added the following assets of type org.carads.Ads
            | adsId | owner | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
            | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
        Then I should have the following assets of type org.carads.Ads
            | adsId | owner | description | bannerUrl | fromDate | kickOffDate | toDate | area | minNumberOfCar| maxNumberOfCar | travelDistance | price |
            | 57934d92-45f6-11e8-842f-0ed5f89f718b | 5c6745b8-45f5-11e8-842f-0ed5f89f718b | I need 2 cars for Ads | PandGBanner.jpg | 2017-05-11 | 2017-05-18 | 2017-07-01 | Hochiminh city | 2 | 2 | 2100 | 5000000 |
