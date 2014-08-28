<cfscript>
    if (structKeyExists(url,"reset")){
        ApplicationStop();
        location("./",false);
    }

    ormReload();

    contact = entityNew("Contact",{firstname:"jc"});
    EntitySave(contact);
    writeDump(contact);
</cfscript>