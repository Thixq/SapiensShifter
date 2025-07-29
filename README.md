# Sapiens Shifter


<a href="https://testflight.apple.com/join/fUKbwzr3"><img src="./project-image/icons/testflight.webp" alt="TestFlight" width="30"></a><p>The app is available on TestFlight. Try it out before October 25, 2025!</p>
<a href="https://www.figma.com/design/NndlnxrOODw170AugPWby5/Sapiens-Shifter?node-id=0-1&p=f"><img src="./project-image/icons/figma.png" width="30"></a><p>Project design file</p>




### Splash, Onboard, Sign In
<p float="left">
  <img src="./project-image/figma-images/splash-screen.png" alt="drawing" width="150"/>
  <img src="./project-image/figma-images/sign-in.png" alt="drawing" width="150"/>
  <img src="./project-image/figma-images/open-tables.png" alt="drawing" width="150"/>
  <img src="./project-image/figma-images/menu.png" alt="drawing" width="150"/>
  <img src="./project-image/figma-images/order-detail.png" alt="drawing" width="150"/>
  <br>
  <img src="./project-image/figma-images/shift.png" alt="drawing" width="150"/>
  <img src="./project-image/figma-images/chat-preview.png" alt="message page" width="150"/>
  <img src="./project-image/figma-images/admin-settings.png" alt="Profile" width="150"/>
  <img src="./project-image/figma-images/all-open-tables.png" alt="all open order list" width="150"/>
  <img src="./project-image/figma-images/new-product-add.png" alt="new prodcut add" width="150"/>
</p>

## What is it?
I built this application for the coffee shop where I previously worked. It enables staff to view and manage their shift schedules, communicate internally via chat, and handle customer orders through a lightweight interface. After showcasing the app to several peers, the feedback was consistent — it has strong potential to be adapted for use across various types of businesses. I share this perspective, but scaling and productionizing the solution would require collaboration beyond a solo effort.

## Technologies Used
- **Flutter** – Cross-platform framework for building iOS and Android applications  
- **Firebase Firestore** – Cloud-hosted NoSQL database for real-time data management  
- **Firebase Storage** – For storing media and other user-generated content  
- **Firebase Cloud Messaging (FCM)** – For sending push notifications to users  
- **Firebase Cloud Functions** – For serverless backend logic and notification automation
> Note: The app is primarily built using Firebase technologies, but its modular architecture allows for easy replacement with alternative services if needed.

## My Experiences

Project Journey & Learning Objectives
From the outset, I chose to fully engage with every phase of app development—in design, planning, coding, testing, and deployment—to build both the application and my expertise. Although I’m not a professional designer, I crafted the UI/UX by adapting proven designs (see references at the end of this document) and learned firsthand how crucial user experience is to an app’s success.

Workflow Planning & Documentation
Before writing a single line of code, I mapped out each screen’s states, wireframed key widgets, and identified shared services (e.g., networking, localization). Documenting these details accelerated development dramatically: some pages went from blank canvas to production-ready in a single day. Conversely, skipping this planning led to subtle bugs that crept in near project completion.

Collaborative Development & Standards
Effective teamwork requires clear roles and a shared coding standard. For example, one developer implements HTTPS requests in a UsersService class, another focuses on widget design, and a third composes screens. We enforce consistency via Git branches and pull requests, ensuring that networking code produces data in the format expected by our widgets, and that UI components remain reusable across screens.

Robust Testing & Error Handling
Consider a user‑info API returning three possible outcomes:

A known user (e.g., "Kaan") → mark isHandsome = true

A different user → isHandsome = false

No data (null)

Without full coverage, null responses crash the app. Unit tests now verify all scenarios, and our code either throws a meaningful exception (e.g., “User not found”) or returns an empty placeholder object—guaranteeing predictable app behavior and clear user feedback.

Logging & Diagnostics
Comprehensive logs have been indispensable. When sending push notifications via FCM, I could immediately tell whether a message was dispatched, whether FCM delivered it, or whether the recipient had notifications disabled. I even track service startups in the app, logging each step at INFO level to streamline debugging.

Expanding My Engineering Perspective
Building a WhatsApp‑style chat revealed the complexity behind message ordering, local storage, search, sync, and encryption. Today’s tech may boil down to zeros and ones, but scalable, secure messaging is an engineering marvel. This project broadened my vision and showed why major companies invest heavily in architecture and planning.

Next Steps
I plan to deepen my iOS expertise by learning Swift alongside Flutter, gain backend experience with Go, and explore embedded systems programming in C/C++. While mastering all these in a short timeframe isn’t feasible, I now understand that choosing the right tool for the job—and knowing where to look—is what truly matters.

## References and Acknowledgements

### References

- [Member registration and login screen (unfortunately removed)](https://dribbble.com/shots/15889044-Login-Register-Mobile-App)
- [Home screen](https://ui8.net/dpopstudio/products/coffeinopia---coffe-shop-app-mobile-ui-ux)
- [Chat screen](https://apps.apple.com/us/app/messages/id1146560473)
- [Shift screen](https://dribbble.com/shots/22106737-Shifter-Mobile-App)
- [Font (Geist)](https://vercel.com/font)

### Acknowledgements

@VB10, also known as Veli BACIK, creates content on [YouTube](https://www.youtube.com/@HardwareAndro) that is very meaningful to me. I’ve watched his videos multiple times — at first, I struggled to understand them, but eventually, I experienced those 'aha' moments. Many of the approaches in this project are outputs I have blended with his ideas. He produces great content for Turkish developers. I especially wanted to thank him for the support he provides to developers in Turkey and for the project he did for [Hatay](https://www.hatayiyasat.com/), which truly deserves great appreciation.