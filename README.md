# Voluntracker
Voluntracker is a project aimed at providing efficient organization and coordination for community relief efforts during times of crisis, with a focus on Goal 11: Sustainable Cities and Communities and Target 11.b. The goal is to create a platform that brings community members together to effectively help each other during times of crisis, such as the devastating earthquakes that hit the Turkey-Syria region in February 2023.

The earthquake's aftermath highlighted the lack of organization and coordination in the relief efforts, which led to inefficiencies in the distribution of volunteers and supplies to help centers. As volunteers in the earthquake relief efforts, the team members of Voluntracker experienced the challenges of tracking and managing the needs of multiple help centers, resulting in some centers being overwhelmed with volunteers while others struggled with insufficient support.

To address this issue, Voluntracker aims to create an application that streamlines the organization efforts at help centers, making it easier for volunteers to find the right centers to help and for help centers to efficiently manage their needs for supplies, equipment, and physical labor. The platform will provide a central hub for communication and coordination among volunteers and help centers, reducing reliance on external tools like WhatsApp and Google Spreadsheets.

By leveraging technology to improve the efficiency of community relief efforts, Voluntracker aims to make a positive impact in times of crisis and contribute towards achieving Goal 11 and Target 11.b of Sustainable Development Goals. The project is driven by first-hand experiences of the team members who have witnessed the challenges of relief efforts and aims to make a meaningful contribution towards more effective community response during times of crisis. Join us in our mission to create a more efficient and coordinated approach to community relief efforts with Voluntracker. Let's make a difference together!

Our main product is our Android application, which you can find under releases, but you can check out our web application  in a really early stage at [voluntracker.app](https://voluntracker.app). In the near future, we will be releasing our iOS and macOS applications as well.

## Table of Contents

- [Google Technologies Used](#google-tech-used)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Authors](#authors)
- [Contact Us](#contact-us)

## Google Technologies Used

- Firebase
  - Firebase Cloud Messaging
  - Firebase Storage
  - Firebase Crashlytics
  - Firebase Analytics
- Google ML Kit
  - Face Detection
  - Image Labeling (not implemented yet, under development)
  - Barcode Scanning (not implemented yet, under development)
- Flutter
- Google Maps API
- Google Cloud
  - Cloud Build
  - Cloud SQL
  - Cloud Run

## Screenshots

## Screenshots

| Welcome Page | Signup Page | Login Page | Forgot Password Page |
| ------------ | ------------ | ------------ | ------------ |
| ![Welcome Page](screenshots/Welcome_Page.jpg) | ![Signup Page](screenshots/Signup_Page.jpg) | ![Login Page](screenshots/Login_Page.jpg) | ![Forgot Password Page](screenshots/Forgot_Password_Page.jpg) |
| Volunteer Home Page | Help Centers List | Help Center Details | Profile |
| ![Volunteer Home Page](screenshots/Volunteer_Landing_Page.jpg) | ![Help Centers List](screenshots/Help_Center_list_page.jpg) | ![Help Center Details](screenshots/Help_Center_Details.jpg) | ![Profile](screenshots/Profile_Details_age.jpg) |
| Edit Profile Page | Map | Map Help Center Details | Volunteer Teams List |
| ![Edit Profile Page](screenshots/Edit_Profile_Page.jpg) | ![Map](screenshots/MapView.jpg)  | ![Map Help Center Details](screenshots/Map_Help_Center_Details.jpg) | ![Volunteer Teams List](screenshots/Volunteer_Teams_List.jpg) |
| Volunteer Team Details | Volunteer Team Detail Options | Assign Volunteer To Team | Assign Team Leader |
| ![Volunteer Team Details](screenshots/Volunteer_Team_Detail.jpg) | ![Volunteer Team Detail Options](screenshots/Volunteer_Teams_List_Options.jpg) | ![Assign Volunteer To Team](screenshots/Volunteer_Team_Add_Volunteer.jpg) | ![Assign Team Leader](screenshots/Volunteer_Team_Assign_Leader.jpg) |
| Remove Volunteer | Create Help Center Page | Help Center Details | Needed Supply List |
| ![Remove Volunteer](screenshots/Volunteer_Team_Remove_Leader.jpg) | ![Create Help Center Screen](screenshots/Create_Help_Center_Page.jpg) | ![Help Center Details](screenshots/Help_Center_Details.jpg) | ![Needed Supply List](screenshots/Needed_Supply_List.jpg) |
| Update Help Center Details | Needed Volunteers List | Needed Volunteer Creation | Needed Supply List |
| ![Update Help Center Details](screenshots/Help_Center_Details_Update.jpg) | ![Needed Volunteers List](screenshots/Needed_Volunteers_List.jpg) | ![Needed Volunteer Creation](screenshots/Needed_Volunteer_Creation.jpg) | ![Needed Supply Creation](screenshots/Needed_Supply_Creation.jpg)|




## Installation

To get started with the project, please follow these steps:

1. Clone the repository:

   git clone https://github.com/CanErsoy20/voluntracker.git

### Frontend

2. Install Flutter through the [official guide](https://docs.flutter.dev/get-started/install). Also install an emulator through the guide if you aren't planning to use on a physical device.

3. Install the dependencies:

```
   cd frontend
   flutter pub get
```

4. Add Google Maps API Key

   Navigate to: frontend\android\app\src\main\AndroidManifest.xml. Change API_KEY_HERE with your API key from Maps SDK for Android.

```
        <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="API_KEY_HERE"/>

```

5. Follow the [official Flutter run instructions]() to run either on an emulator or a physical device. 
Or you can build the project on following architectures:

- [Android](https://docs.flutter.dev/deployment/android)
- [iOS](https://docs.flutter.dev/deployment/ios)

### Backend

Building a server is not mandatory, but if you are planning on building your server instance follow these steps:

2. Install Node.js and NPM through the [official guide](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm). Here is the link to [official downloads](https://nodejs.org/en/download).

3. Install the project dependencies:
```
   cd backend
   npm install
```

4. Set up environment variables:

   Place an .env file in the root directory of the project. The file should contain the following variables:

   ```
      DATABASE_URL=
      NODE_ENV=DEV
      JWT_ACCESS_SECRET=
      JWT_REFRESH_SECRET=
      FIREBASE_PROJECT_ID=
      FIREBASE_PRIVATE_KEY=
      FIREBASE_CLIENT_EMAIL=
      FIREBASE_DATABASE_URL=
   ```
   For database URL, you can use the following template or check out [Prisma documentation](https://www.prisma.io/docs/reference/database-reference/connection-urls):
   ```
      postgres://<username>:<password>@<host>:<port>/<database>
   ```

   For Firebase variables, you can check out [Firebase documentation](https://firebase.google.com/docs/admin/setup#initialize-sdk) or you can download the service account key from Firebase console.
   
   For JWT secret keys, using the [HMAC algorithm is recommended](https://jwt.io/introduction). Though, it will work with any kind of string.


5. Set up the database and start the development server:

   ```npm run start:migrate```

6. Change API URL in frontend

  Navigate to: frontend\lib\constants\api_constants.dart
  
  Change
  
 ``` static String baseUrl = "https://api.voluntracker.app/v1/"; ```
  
  to match your backend endpoint.


## Usage

To use the application, follow these steps:

1. Install the application on your Android or iOS device.
2. Open the application and create an account.
3. Log in to the application and start using it.

## Contributing

As this is a Google Solution Challenge project, we do not allow third-party contributions at this time.

## License

This project is licensed under the MIT License.

## Authors

- Berra Yüce [📧](berrayuce@gmail.com)[🌐]()[<img src="./icons/Github-Dark.svg" width="24">]()
- Can Ersoy [📧](canersoy2002@gmail.com)[🌐]()[<img src="./icons/Github-Dark.svg" width="24">]()
- Selim Can Güler [📧](mailto:cs.selim.guler@gmail.com)[🌐]()[<img src="./icons/Github-Dark.svg" width="24">]()
- Tolga Özgün [📧](mailto:tolgaozgunn@gmail.com)[🌐](https://tolgaozgun.com)[<img src="./icons/Github-Dark.svg" width="24">](https://github.com/tolgaozgun)

## Contact Us

Feel free to contact us via contact@voluntracker.app or you can use our private emails listed above.
