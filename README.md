# Furnishly App

Furnishly is a Flutter-based e-commerce application designed to provide users with a seamless shopping experience. It incorporates features like user authentication, product browsing, category filtering, and a personalized shopping cart. The app is powered by Firebase and Hive for robust backend support.

## Table of Contents
  - [Home Page](#home-page)
  - [Categories Page](#categories-page)
  - [Account Page](#account-page)
  - [Cart Page](#cart-page)
  - [Contact Us Page](#contact-us-page)
  - [General Features](#general-features)
  - [Screenshots](#screenshots)
  - [Installation](#installation)
  - [License](#license)

## Features

### Home Page
- **App Bar**: Custom app bar with the store name in yellow  and sign-in/sign-out options.
- **Search Bar**: Allows users to search for products by name.
- **Hot Deals Section**: Highlights special promotions and discounts with an option to "Show More".
- **Product Categories**: Displays products from various categories like Office, Living Room, Bedroom, Dining Room, and Outdoors.
- **Product Display**: Tapping on a product opens a detailed product page. Each product is shown with an image, title, description,  discount dmount (if applicable) , and price. The product image features a heart icon in the top right corner, allowing users to add or remove the item from their wishlist. When an item is favorited, the heart icon is filled in red. If the product is in stock, an "Add to Cart" button is available, If out of stock, the button is disabled and labeled "Out of Stock.". Users cannot add more items to their cart than the available stock quantity.
- **Product Filtering**: Selecting "Show More" in a category opens a dedicated product page with the category filter chip pre-selected for fast browsing.
- **Drawer**:The drawer includes the following options: **Wishlist** to view your favorite products, **My Orders** to check your past orders sorted with the most recent orders displayed first, **Contact Us** for reaching out to the store, and **FAQ** for frequently asked questions.


### Categories Page
- **Grid of Categories**: Displays clickable categories that show respective products.
- **Viewing Products**: Selecting a category opens a page with the filter chip for that category pre-selected.

### Account Page
-  **Sign-in Page**: If the user is not signed in, a Sign-in page is displayed featuring fields for email and password. It includes a "Forgot Password" option for resetting the password using Firebase, a sign-in button, a "Sign in with Google" button, and an option to sign up for users who do not have an account.
-**Edit Account Page** If the user is signed in, the interface provides options to **Edit account information**, **View the wishlist**, **Check past orders**, and **Sign out**.
- **Data Persistance**: User data is saved locally using Hive, allowing for data persistence. This enables multiple users to access the app from the same mobile device while retaining their individual information.
- **Email Verification**: An email verification link is sent when a user signs up using email/password. This ensures that users have a valid email address. However, email verification is not required for purchase functionality to simplify testing.
- **Google Sign-In**: Users can sign in with their Google account. If the user does not have an account, a new account is automatically created with the user's Google credentials (such as display name and email).
- **Secure Local Storage**: The app encrypts the Hive box with AES encryption to safeguard sensitive data. The encryption key is securely stored in the Keystore via the Flutter_Keychain package, ensuring that user information remains protected from unauthorized access.





### Cart Page
  - **Displays Products in Cart**: If the cart is empty it displays "Cart is empty", otherwise it displays products in cart with an option to increase/decrease quantatity and remove from cart.
  - **User's Personal Cart**: Each user has a personal cart that is saved locally using Hive. Additionally, if a user adds products to the cart before signing up, those items will be transferred to their cart upon account creation.
  - **Checkout**: If user is signed in he can proceed to checkout. The checkout page comes prefilled with the user's name, address, phone number. Users can select a delivery date and payment method, as well as enter a promo code. At the bottom of the page, the order information is displayed, including the subtotal, discounts, any applied promo codes, shipping fees, and the total amount.
  - **Data Persistance**: Users carts are saved locally to the device using Hive.
  - **Out of Stock Notification**: In the event that a product goes out of stock while in cart and the user tries to proceed to checkout, a dialog will inform the user. This notification will also appear if the user attempts to purchase more items than are currently available in stock.
    
 ### Contact Us Page
 - The **Contact Us** page includes our phone number, which, when clicked, opens the dialer for calling. The email address is also clickable, launching the user's email client to send a message. Additionally, our physical location is provided. At the bottom of the Contact Us page, there are text fields for submitting an inquiry form. The page also features clickable links to our social media profiles on Facebook, Instagram, and X (formerly Twitter) which open another pages since the business is fictional.

### General Features
  - **Responsiveness**: The app utilizes MediaQuery to adjust to various screen sizes effectively.
  - **Authentication**: The app utilizes Firebase Authentication for user authentication, allowing users to sign in with their email and password. It includes features for changing email addresses and resetting passwords, ensuring a secure and user-friendly experience.
  - **Security Measures**: The app implements strong security protocols by requiring passwords to have a minimum of 8 characters, at least one uppercase letter, at least one number, and at least one special character. These requirements help ensure that user accounts are well-protected.
  - **Input Field Configuration and Validation**: Phone fields utilize the phone keyboard type, while email and address fields are configured with the appropriate keyboard types. Each input field is designed to ensure users have the correct keyboard for their entries. Additionally, validation is implemented to ensure that phone numbers cannot contain letters.

## Screenshots
<img src="https://github.com/user-attachments/assets/0cdb51e3-9ddd-47d4-b829-0231a43b3e33" alt="screenshot (2)" width="300" height="500">
<img src="https://github.com/user-attachments/assets/ed854743-b2b7-4fc7-b926-0e275c2a5526" alt="screenshot2" width="300" height="500">
<img src="https://github.com/user-attachments/assets/0f99b8d7-b984-44b0-a436-b9a648df599b" alt="screenshot3" width="300" height="500">
<img src="https://github.com/user-attachments/assets/5ffffcb5-9983-4e93-92e8-3678aa5a2140" alt="screenshot4" width="300" height="500">
<img src="https://github.com/user-attachments/assets/77a113b5-855d-4701-8c16-d69ab76be63a" alt="screenshot5" width="300" height="500">
<img src="https://github.com/user-attachments/assets/2223e10c-bff2-4033-8465-44508f84f3ae" alt="screenshot6" width="300" height="500">
<img src="https://github.com/user-attachments/assets/9be5cbbf-4343-4795-a1ed-2130a3afc780" alt="screenshot7" width="300" height="500">
<img src="https://github.com/user-attachments/assets/6359c80c-4ef8-41e2-ac7b-615b45d8d95f" alt="screenshot8" width="300" height="500">
<img src="https://github.com/user-attachments/assets/16e25829-45b3-4a8f-8559-363a0a7b0757" alt="screenshot9" width="300" height="500">
<img src="https://github.com/user-attachments/assets/b63aa5de-1940-47bb-8b9b-dfb57ee9fc11" alt="screenshot10" width="300" height="500">
<img src="https://github.com/user-attachments/assets/c2eba8b5-1274-420d-9565-43deb9187ffa" alt="screenshot11" width="300" height="500">
<img src="https://github.com/user-attachments/assets/c402b76b-9e74-4a62-b996-0f90b73ea139" alt="screenshot12" width="300" height="500">
<img src="https://github.com/user-attachments/assets/b597bfbb-9ca1-47d5-a629-f9f8e4abd9ca" alt="screenshot13" width="300" height="500">
<img src="https://github.com/user-attachments/assets/7db2460a-fa4b-4e64-90ca-32fbb16fa27c" alt="screenshot14" width="300" height="500">
<img src="https://github.com/user-attachments/assets/03de4076-6214-4b62-9675-9a391b3b4e7c" alt="screenshot15" width="300" height="500">
<img src="https://github.com/user-attachments/assets/237cddae-0f49-49cd-b7f6-396328ef5ea9" alt="screenshot16" width="300" height="500">
<img src="https://github.com/user-attachments/assets/c4c0b51e-08b2-42f3-b1ce-5af0abe70116" alt="screenshot17" width="300" height="500">
<img src="https://github.com/user-attachments/assets/924757af-0c70-42c4-8b2b-991330023617" alt="screenshot18" width="300" height="500">
<img src="https://github.com/user-attachments/assets/cdecbeb1-0c90-4d3b-a7a7-f3ccc9e71d8e" alt="screenshot19" width="300" height="500">
<img src="https://github.com/user-attachments/assets/3863664b-e185-4e01-bf2f-2542f313416c" alt="screenshot20" width="300" height="500">
<img src="https://github.com/user-attachments/assets/34dda75e-7dd1-4d82-bc8c-577f4f079de4" alt="screenshot21" width="300" height="500">
<img src="https://github.com/user-attachments/assets/02d77e10-e810-45da-9cd5-a1312ab1e1fe" alt="screenshot22" width="300" height="500">

## Installation

1. **Clone this repository**:
    ```bash
    git clone https://github.com/AmrQ34327/Furnishly.git
    ```

2. **Navigate to the project directory**:
    ```bash
    cd Furnishly
    ```

3. **Install the necessary dependencies**:
    ```bash
    flutter pub get
    ```

4. **Run the app**:
    ```bash
    flutter run
    ```

### Android Setup for URL Launching (Android 11 and above)

For Android 11 (API level 30) and above, the `url_launcher` plugin requires that any URL schemes passed to `canLaunchUrl()` be declared in the `<queries>` element of your `AndroidManifest.xml`. This ensures your app can check for support of various schemes, such as `sms`, `tel`, and in-app browser services.

Please refer to the [url_launcher package page](https://pub.dev/packages/url_launcher) for more information.

## License

All rights reserved. No part of this code may be reproduced, modified, or distributed without permission.




    
    


