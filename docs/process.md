# <span style="color:blue">**Process Documentation**</span>

## <span style="color:blue">1. Project Scope</span>
The scope of the project is to investigate how the digitalisation affects business processes in an enterprise, how an ideal interaction of natural and artificial intelligence in an organisational environment can be achieved, and how cooperation and partnership among humans and technology can result in adequate business process execution. This investigation will be realised by application, implementation and demonstration of real prototypical instantiations.

## <span style="color:blue">2. Team Members</span>

| Name | Email |
|---|---|
| Jasmin Fluri  | jasmin.fluri@fhnw.ch |
| Alena Magliano | alena.magliano@students.fhnw.ch |
| Alain Schmutz | alain.schmutz@students.fhnw.ch |

## <span style="color:blue">3. Use Case Identification</span>
The team has worked together in a brainstorming phase on identification of use case they would like to work on. It was decided to model a process owned by company of one of the team members. The process presents the procedure for the new proposals with respect to changing the business guidlines, innovation, general improvements or future events inside the company. It has to be pointed out that the process does not relate to external clients.


## <span style="color:blue">4. Scenario and User Experience (UX)

### Project Use Case

The company structure of Schaltstelle (schaltstelle.ch) allows each member of the company to have the same power of co-decision. No management rules over the company. If decisions have to be made, the members decide according to the principle of consent. The principle of consent means, as long as no member disapproves, the voting at hand is accepted. 

If a topic needs to be put to the vote, the related member has to explain it to the others, so that they can veto against it, if they disapprove. If any member disapproves, the proposal is declined. It is not a majority decision where the outcome is defined in what most members vote. 

Votings of proposals and their discussion and improvement suggestions are currently set up as a Telegram chatroom. The structure of a chatroom complicates the tracking of the status of proposals and their outcomes.

## <span style="color:blue">5. Process Modelling


The process contains three roles: A requester, an innovation manager and the remaining members of the company.

| Role | Description |
|---|---|
| Requester | Person who can raise the new proposal and is necessarily a member of the company. |
| Innovation Manager | Person who is responsible for reviewing the new proposal. He makes suggestions to refine the proposal before it is up for voting. |
| Members | Members of the company who can make use of the right to veto. Any member has the possibility to propose requests. |


 Proposals that are up for voting can be classified amongst the following categories: 
 * Change of business guidelines (code of conduct, code of ethics)
 * Innovation (new business ideas or projects)
 * General improvements (office, infrastructure, technologies)
 * Future events (regulars' table, networking events, team events)
 * Marketing (social media, website, sponsoring)
 * New Member

The current process to request proposals is done in the chat application Telegram. There is no overview of the ongoing proposals, no possibility for improvement suggestions by other members of the company and discussions are hard to follow.

## <span style="color:blue">6. Process AS-IS Description</span>

### Process AS-IS Description


The process starts with the requester creating a proposal. It must be phrased to allow a yes / no decision. The Chief of innovation reviews the proposal. If the proposal is not complete, it is handed back to the requester. If the Chief of innovation declares the proposal as complete, the proposal is ready for voting. Next, the members need to decide if they want a pitch or presentation of the proposal to learn about its details. This can help to get a better understanding of the request or the idea. If not, the 10 days right to veto starts for all the members. During this period, two tasks commence: 
- Members of the company could suggest improvements to the proposal. The improvements can be accepted by the requester and implemented into the description. If the requestor rejects the improvements, nothing changes.
- Members of the company can make use of their right to veto. If at least one member makes the use of the right to veto, the proposal is declined, and the process ends. If the members do not make their use of the right to veto within the ten days, the proposal is accepted, and the process ends.



## <span style="color:blue">7. Decision Logic</span>


Decision logic is represented as a decision table which consists of inputs, output and rules. The inputs are conditions and the outputs are the concslusion of the rules. In AS-IS Process, the members have to decided if they want a pitch or presentation of the proposal. This step can be automated with the help of decision table. With the pre-defined inputs, outpus and rules can be decided if the presentation is needed.
In the decision table there are 2 inputs and one output.

INPUT                     
* Proposal Category        
* Amount Budgeted

OUTPUT
 * Decision Outcome

The following table represents the decision logic. If the proposal category is innovation and the amounted budget is greater than CHF 1000 then the presentation or pitch is needed. If the proposal category is marketing and the amounted budget is greater than CHF 2000 then the presentation or pitch needed. If the proposal category is future events and the amounted budget is greater than CHF 3000 then the presentation or pitch needed. If the proposal category is new members athen the presentation or pitch is always needed.

|Proposal Category | Amount Budgeted | Decision Outcome|
|---|---|---|
| Innovation | > 1000 |true|
| Marketing | > 2000 |true|
| Future Events | > 3000 |true|
| New Members | > 0 |true|
|"Innovation","GeneralImprovements","FutureEvents","Marketing" "ChangeOfBusinessGuidelines"|- |false|

## <span style="color:blue">8. Identification of Digitalisation Aspects</span>

## <span style="color:blue">9. Process TO-BE Description</span>

### Process TO-BE Description

## <span style="color:blue">10. Deployement of External Services and </span>

## <span style="color:blue">11. Deployment of Project</span>



## <span style="color:blue">12. Testing of Project</span> 

## <span style="color:blue">13. Summary</span>