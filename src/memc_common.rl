%%{
    machine memc_common;

    action catch_err {
        dd("caught error...");
        dd("machine state: %d", cs);

        *status_addr = NGX_HTTP_BAD_GATEWAY;
    }

    msg = any* -- "\r\n";

    error_helper = "ERROR\r\n"
                 | "CLIENT_ERROR " msg "\r\n"
                 | "SERVER_ERROR " msg "\r\n"
                 ;

    error = error_helper @catch_err
          ;

    action finalize {
        dd("done it!");
        *done_addr = 1;
    }

    action check {
        dd("state %d, left %d, reading char '%c'", cs, pe - p, *p);
    }

}%%

