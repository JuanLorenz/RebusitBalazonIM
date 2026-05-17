# WildSTAR (Study Area Reservation) System
- A system for making study area reservations throughout the University. A user can register through their email and department, and then choose a study area or resource available to them at a given time. Once the reservation starts, they go to the Admin to be marked as present and use the study area during the alloted time (only one hour). The diagram is shown below. By following the rules (below the diagram), a responsible user can avoid being blocked and freely keep reserving for areas at their heart's content.

### Entity Relationship Diagram
![Diagram](<New Diagram.png>)

### Business Rules
1. A user/reservation participant can only reserve once at a time. If they have a current reservation that’s ‘Pending’ or ’Active’, they can’t reserve another one until it finishes.
2. A user can only reserve a spot for the same day.
3. During the reservation, the participants must go to the Admin first for check-in. The rules are up to their discretion.
4. The admin can only see reservations marked as 'Pending' or 'NoShow'.
5. If the user is marked present by the Admin before the end time, the reservation status changes to 'Active'. After the end time, the status changes to 'Completed'.  
6. If the user is not marked present by the Admin before the end time, the reservation status changes to ‘NoShow’.
7. A user can be blocked or unblocked by the Admin. The rules are up to their discretion.
8. A user can not make reservations for 7 days if they're blocked.
9. A single reservation can only have a one hour time allotment.
10. A study area can either be open to all departments or restricted to specific departments.
11. A reservation can only be made for a study area that is open to the department they belong to.
12. The amount of participants in a reservation must be within the minimum and maximum capacity (inclusive) a resource can hold.
13. No two or more reservations can be made for the same resource at the same time.
14. The study area, date and time must be unique for all reservations.
15. All reservations are made final. Once a reservation is made, no cancellations or edits can be performed.
