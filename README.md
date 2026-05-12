# WildSTAR (Study Area Reservation) System
- a system for making study area reservations throughout the University. *(If you see this message, then I was too lazy to continue this paragraph)*

### Entity Relationship Diagram
![Diagram](<New Diagram.png>)

### Business Rules
1. A user/reservation participant can only reserve once at a time. If they have a current reservation that’s ‘Pending’ or ’Active’, they can’t reserve another one until it finishes.
2. A user can only reserve a spot for the same day.
3. During the reservation, the user must go directly to the Admin for them to mark the user as present.
4. At least one participant from the reservation is required to be present (in the first 15 minutes) to make the reservation ‘Active’.
5. After the 15 minutes are done and no participant is present, the reservation is marked as ‘No Show’.
6. A user is blocked if they weren’t present during the reservation period, or if the reservation is marked as ‘No Show’.
7. A blocked user cannot make reservations for 7 days.
8. A user can be unblocked early by the Admin. The requirements are up to their discretion.
9. A single reservation can only have a one hour time allotment.
10. A study area can either be open to all departments or restricted to specific departments.
11. A reservation can only be made for a study area that is open to the department they belong to.
12. The amount of participants in a reservation must be within the minimum and maximum capacity (inclusive) a resource can hold.
13. No two or more reservations can be made for the same resource at the same time.
14. The study area, date and time must be unique for all reservations.
15. All reservations are made final. Once a reservation is made, no cancellations or edits can be performed.