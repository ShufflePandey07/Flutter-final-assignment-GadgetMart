# Gadget Mart

A Flutter-based frontend for the Gadget Mart eCommerce mobile app, offering a tailored interface for customers to browse and purchase products, manage orders, and handle their personal information.

## Features

### User Role

- **Product Search**: Browse and filter products based on categories, price, and preferences.
- **Favourites**: Add products to favourites for easier future purchases.
- **Cart & Checkout**: Add products to the cart, review orders, and proceed to checkout.
- **Order History**: View and manage personal order history.
- **Profile Management**: Update personal details, addresses, and payment methods.

## Technologies

- **Flutter**: Core framework for building the app.
- **Riverpod**: State management solution.
- **Tailwind CSS**: UI styling (Note: Tailwind CSS is generally for web; for Flutter, you may use built-in styling or alternative packages.)

## API Integration

The Flutter app communicates with the backend via a RESTful API, handling operations such as product management, order processing, and user data handling.

## Future Works

- **AR Try-On Expansion**: Extend the virtual try-on feature to include more accessories such as hats and earrings for a more comprehensive experience.
- **Enhanced Personalization**: Implement AI-driven recommendations based on user preferences and past behavior to suggest products more accurately.
- **In-Store Pickup Option**: Introduce an option for users to reserve products online and pick them up at a physical store location.
- **Social Media Integration**: Enable users to share their try-on experiences and favorite products directly on social media platforms.

## Challenges

- **State Management**: Managing complex state across various components, particularly with features like virtual try-on, user authentication, and shopping cart, was handled using Riverpod and clean architecture principles.
- **AR Integration**: Integrating augmented reality for the virtual try-on feature in a mobile environment required overcoming challenges related to performance, accurate rendering, and compatibility with different devices.
- **Responsive Design**: Ensuring that the user interface remained consistent and functional across a wide range of devices and screen sizes was achieved through Flutter’s responsive layout features.
- **API Integration**: Handling API requests for real-time product updates, user authentication, and AR data processing while maintaining smooth and secure communication was crucial and required thorough testing.

## Environment Variables

- `API_URL`: http://localhost:5000
- `KHALTI_URL`: https://test-pay.khalti.com/
- `KHALTI_PUBLIC_KEY`: 0800545e039d45368cab4d1b2fb93d01
- `AR_SERVICE_URL`: The URL for the Augmented Reality service used in the virtual try-on feature.

## Sensor Integration

- **Fingerprint Sensor**: Secure authentication simulation
- **Gyroscope**: Interactive UI elements
