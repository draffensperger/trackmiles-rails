# TrackMiles
Project to for Automating Cru Mileage Reimbursements

## Summary
I’ve created a prototype Android app and website to prepare mileage reimbursements for Cru staff based on their Google Calendar and phone locations. A screencast that current state of the project is here: http://www.youtube.com/watch?v=wh_xTOfBhaY

Next steps would be to build an iPhone location tracker app and to add some needed features to the website before getting to the point where we could beta test it among staff, barring any reasons the project shouldn’t move forward.

## Vision

I believe we could help our staff by automating the process of entering mileage reimbursements by using their smart phone location and calendar information. This would ultimately save time and perhaps also motivate some staff to take mileage reimbursements who previously felt it was too much trouble, thus increasing the tax efficiency of our staff and better stewarding ministry funds.

## Current Project Status

I have called my prototype application “TrackMiles” and you can view the website at https://trackmiles.davidraff.com/

Currently the Android app can do the following:
- Allow the user to log in with their Google account that is already stored on the phone (no need to enter password)
- Record the user’s location and upload those to the TrackMiles site

The website does the following:
- Receives and stores the location information from the Android app
- Processes the location information into separate trips, and uses the Google Maps Api to find the driving distance between those locations and to find addresses for the start and end locations

## License

MIT License. See LICENSE.txt for details.
