/**
* @output false
*/
component{

    this.name               = "cfug_rest_api";
    this.sessionManagement  = true;
    this.datasource         = "contacts_api";

    // RESET SETTINGS
    this.restsettings.autoregister              = true;
    this.restsettings.host                      = "api.local.com";
    this.restSettings.cfclocation               = "/rest/";
    this.restsettings.skipcfcwitherror          = false;    
    this.serialization.preservecaseforstructkey = true;

    // ORM
    this.ormEnabled     = true;
    this.ormSettings    = {
        automanageSession       : false,
        cfclocation             : "/orm/",
        dbcreate                : "update",
        // dialect                 : "org.hibernate.dialect.MySQL5InnoDBDialect",
        useDBForMapping         : false
    };

}