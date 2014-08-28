/**
*   @table          contacts
*   @entityname     Contact
*   @output         false
*   @persistent     true
*/
component 
{
    property name="id"                  fieldtype="id"      generator="native";
    property name="firstName"           ormtype="string"    length="155";
    property name="middleInitial"       ormtype="string"    length="1";
    property name="lastName"            ormtype="string"    length="155";
    property name="dob"                 ormtype="date";
    property name="email"               ormtype="string"    length="20";
    property name="phone"               ormtype="string"    length="20";
    property name="cell"                ormtype="string"    length="150";
    property name="created"             ormtype="timestamp";
    property name="modified"            ormtype="timestamp";

    public void function init(){
        var today = now();
            setCreated(today);
            setModified(today);
    }

    public void function preUpdate( struct oldData ){
        setModified(now());
    }

}