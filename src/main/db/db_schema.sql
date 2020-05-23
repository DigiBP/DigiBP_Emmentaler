CREATE TABLE  "ANTRAG" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"TITLE" VARCHAR2(500) NOT NULL ENABLE, 
	"DESCRIPTION" VARCHAR2(4000), 
	"APPLICANT" VARCHAR2(100) NOT NULL ENABLE, 
	"BUDGET" NUMBER, 
	"CATEGORY" VARCHAR2(255) NOT NULL ENABLE, 
	"SUBMISSION_DATE" TIMESTAMP (6) NOT NULL ENABLE, 
	"IS_REVIEWED" VARCHAR2(50), 
	"HAS_VETO" VARCHAR2(50), 
	"PROPOSAL_STATUS" VARCHAR2(100) NOT NULL ENABLE, 
	"REVIEW_DATE" TIMESTAMP (6), 
	"LINKS" VARCHAR2(4000), 
	"REVIEW_STATUS" VARCHAR2(100), 
	"IS_PITCH_NEEDED" VARCHAR2(50), 
	"VETO_START_DATE" TIMESTAMP (6), 
	"HAS_CHANGE" VARCHAR2(50), 
	"CAMUNDA_INSTANCE" VARCHAR2(200), 
	 CONSTRAINT "ANTRAG_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
/

CREATE TABLE  "CHANGE" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"ANTRAG_ID" NUMBER NOT NULL ENABLE, 
	"CHANGE_TITEL" VARCHAR2(100), 
	"CHANGE_DESC" VARCHAR2(4000), 
	"IS_ACCEPTED" VARCHAR2(50), 
	 CONSTRAINT "CHANGE_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "CHANGE" ADD CONSTRAINT "CHANGE_ANTRAG_FK" FOREIGN KEY ("ANTRAG_ID")
	  REFERENCES  "ANTRAG" ("ID") ON DELETE CASCADE ENABLE
/
