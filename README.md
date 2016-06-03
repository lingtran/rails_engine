== README

**Getting Started**
  * ``git clone https://github.com/lingtran/rails_engine.git``
  * ``bundle``
  * ``rake db:reset``
  * ``rake import_data:all``
    * If the task for single load above does not work, individually ``rake`` task in the following order:

      * ``rake import_data:customers``
      * ``rake import_data:merchants``
      * ``rake import_data:invoices``
      * ``rake import_data:items``
      * ``rake import_data:invoice_items``
      * ``rake import_data:transactions``


**Root API endpoint**
  * http://localhost:3000/api/v1/


**Note to evaluator**
  * Spec harness is down to two failures/errors
  * [Link to spec harness](https://github.com/turingschool/rales_engine_spec_harness)