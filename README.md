NYC Schools by [Amos](https://github.com/amostodman)

Displays a list of NYC High Schools.

Data is decoded from JSON data via a web REST API.

Selecting a school shows additional information about the school
- Displays all the SAT scores if included in the JSON response from the API (Displays the text "No data" otherwise).
- Data displays Math, Reading and Writing score averages.

Technologies used:
- Design pattern: MVVM
- Unit testing
- Combine
- SwiftUI
- Dependency Injection
- REST API data decoding (JSON)
- Search/Filter List

API Reference and Documentation:
- [DOE High School Directory 2017](https://data.cityofnewyork.us/Education/DOE-High-School-Directory-2017/s3k6-pzi2)
- [2012 SAT Results](https://data.cityofnewyork.us/Education/2012-SAT-Results/f9bf-2cp4)

Todo:
- Prettify: Add some images or media such as maps or something.
- CI/CD with GitHub actions: Use the device farm from github for UITesting, automatic screenshots, testflight deployment and other automation.
- Add gitignore
- Convert snake case keys from JSON to camel case.
- Separate code into different files for the many possible sections of the school detail view as the page gets bigger.
