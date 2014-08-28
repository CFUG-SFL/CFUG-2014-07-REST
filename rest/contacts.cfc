/**
* @output   false
* @rest     true
* @restPath /contacts
*/
component{


    /**
    * @httpMethod   get
    * @restPath     {contactID}
    * @produces     application/json
    */
    remote struct function pathHandlerJSON(
        required numeric contactID restArgSource="path"
    ){
        return  getContact(arguments.contactID);
    }
    

    /**
    * @httpMethod   get
    * @restPath     {contactID}
    * @produces     application/xml
    */
    remote struct function pathHandlerXML(
        required numeric contactID restArgSource="path"
    ){
        return  getContact(arguments.contactID);
    }

    /**
    * @httpMethod   post
    * @restPath     create
    * @produces     application/json
    */
    remote struct function createContact(
        required string contact restArgSource="form"
    ){
        local.theContact = entityNew("Contact",deserializeJSON(arguments.contact));
        
        transaction { EntitySave(local.theContact); }
        
        return getContact(local.theContact.getID());
    }

    /**
    * @httpMethod   put
    * @restPath     update
    * @produces     application/json
    */
    remote struct function updateContact(
        required string contact restArgSource="query"
    ){
        local.contact       = deserializeJSON(arguments.contact);
        local.theContact    = entityLoadByPK("Contact",local.contact.id);

        if (isNull(local.theContact )){
            local.rtn = {success:"false",message:"The contact requested no longer exists"};
        } else {

            local.theContact.setFirstName(local.contact.firstName);
            local.theContact.setLastName(local.contact.lastName);
            local.theContact.setDOB(local.contact.dob);
            local.theContact.setEmail(local.contact.email); 
            local.theContact.setPhone(local.contact.phone);
            local.theContact.setCell(local.contact.cell);
            local.theContact.setModified(now());

            transaction { EntitySave(local.theContact); }

            local.rtn = {success:"true",message:"The contact was updated"};
        }
        return local.rtn;
    }
    

    /**
    * @httpMethod   delete
    * @restPath     {contactID}
    * @produces     application/json
    */
    remote boolean function deleteContact(
        required numeric contactID restArgSource="path"
    ){
        local.theContact   = entityLoadByPK("Contact",arguments.contactID);

        if (!isNull(local.theContact))
            transaction { EntityDelete( local.theContact); }

        return  true;
    }


    /**
    * @output false
    */
    private struct function getContact(
        required numeric contactID
    ){
        local.theContact = entityLoadByPK("Contact",arguments.contactID);
        if (isNull(local.theContact)){
            local.rtn = {success:"false",message:"The contact requested no longer exists"};
        } else {
            local.rtn = {
                id              : local.theContact.getID(),
                firstName       : local.theContact.getFirstName(),
                middleInitial   : local.theContact.getMiddleInitial(),
                lastName        : local.theContact.getLastName(),
                dob             : local.theContact.getDOB(), 
                email           : local.theContact.getEmail(), 
                phone           : local.theContact.getPhone(),
                cell            : local.theContact.getCell(),
                created         : local.theContact.getCreated(),
                modified        : local.theContact.getModified()
            };
        }
        return  local.rtn;
    }

}