︠cedec87d-8bcc-4a51-bf6b-a86f2c11e248s︠
#---------------------------------EXTENDING WINDOW METHOD---------------------------------
#---------------------evaluate this cell (SHIFT + ENTER) to start GUI---------------------
load('interact_ewm.sage')
︡fb9257b7-cee6-42e7-ae86-596d2d5e41c2︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["name",12,null]],[["minPol",12,null]],[["omegaCC",12,null]],[["alphabet",12,null]],[["inputAlphabet",12,null]],[["base",12,null]],[["setting_name",12,null]],[["",12,null]],[["auto_update",2]]],"id":"461bf2cf-71c4-4170-a2e3-d4f795b11060","controls":[{"default":"<h3>Load inputs: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"eisenstein","label":"Name of the numeration system:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"name","type":"<type 'str'>"},{"control_type":"input-box","default":"x^2 + x + 1","label":"Minimal polynomial of ring generator (use variable x):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"minPol","type":"<type 'str'>"},{"control_type":"input-box","default":"-0.500000000000000 + 0.866025403784439*I","label":"Embedding (the closest root of minimal polynomial to this value is taken as the ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"omegaCC","type":"Complex Field with 53 bits of precision"},{"control_type":"input-box","default":"[0, 1, -1, omega, -omega, -omega - 1, omega + 1]","label":"Alphabet (use 'omega' as ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"alphabet","type":"<type 'str'>"},{"control_type":"input-box","default":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 1, -2*omega - 2, -2]","label":"Input alphabet (if empty, A + A is used):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inputAlphabet","type":"<type 'str'>"},{"control_type":"input-box","default":"omega - 1","label":"Base (use 'omega' as ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"base","type":"<type 'str'>"},{"control_type":"input-box","default":"","label":"Or you can load setting from the file (in folder /examples):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"setting_name","type":"<type 'str'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["max_iterations",12,null]],[["max_input_len",12,null]],[["frame_help",12,null]],[["info",12,null]],[["WFcsv",12,null]],[["localConversionCsv",12,null]],[["saveSetting",12,null]],[["saveLog",12,null]],[["saveUnsolved",12,null]],[["",12,null]],[["auto_update",2]]],"id":"dd51cec3-13ae-4a64-913f-4e1a3e420eee","controls":[{"default":"<h3>Find weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"20","label":"Maximum of iterations to get Weight coefficient set:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"max_iterations","type":"<type 'sage.rings.integer.Integer'>"},{"control_type":"input-box","default":"8","label":"Maximal length of weight function input:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"max_input_len","type":"<type 'sage.rings.integer.Integer'>"},{"default":"Choose required outputs to save:","var":"frame_help","classes":null,"control_type":"text","label":""},{"default":true,"var":"info","readonly":false,"control_type":"checkbox","label":"General info to .tex file:"},{"default":false,"var":"WFcsv","readonly":false,"control_type":"checkbox","label":"Weight function to .csv file:"},{"default":false,"var":"localConversionCsv","readonly":false,"control_type":"checkbox","label":"Local conversion to .csv file:"},{"default":true,"var":"saveSetting","readonly":false,"control_type":"checkbox","label":"Inputs setting:"},{"default":true,"var":"saveLog","readonly":false,"control_type":"checkbox","label":"Log file:"},{"default":false,"var":"saveUnsolved","readonly":false,"control_type":"checkbox","label":"Unsolved inputs after interruption:"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["len_inp",12,null]],[["saveLog",12,null]],[["",12,null]],[["auto_update",2]]],"id":"be17ca2f-6a1c-449b-9c06-f8861c632550","controls":[{"default":"<h3>Sanity check: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":null,"label":"Number of digits for sanity check:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"len_inp","type":"<type 'sage.rings.integer.Integer'>"},{"default":true,"var":"saveLog","readonly":false,"control_type":"checkbox","label":"Save log file after sanity check:"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["inp",12,null]],[["",12,null]],[["auto_update",2]]],"id":"59239ba5-7557-449d-83ba-ae248686557c","controls":[{"default":"<h3>Weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"(omega,1,2)","label":"Input tuple of weight function (use 'omega' as ring generator, zeros are appended if necessary):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inp","type":"<type 'str'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["folder",12,null]],[["_size",12,null]],[["",12,null]],[["auto_update",2]]],"id":"93d4bddd-7fda-414f-a600-a5726365a3eb","controls":[{"default":"<h3>Construction of the weight coefficients set: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"img","label":"Save to folder:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"folder","type":"<type 'str'>"},{"control_type":"input-box","default":7,"label":"Size of image:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_size","type":"<type 'int'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["inp",12,null]],[["folder",12,null]],[["_size",12,null]],[["_legend_xshift",12,null]],[["_legend_yshift",12,null]],[["_legend_distance_factor",12,null]],[["",12,null]],[["auto_update",2]]],"id":"98c7307a-3d07-4322-8366-d21269cc1bd0","controls":[{"default":"<h3>Construction of the weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"(omega,1,2)","label":"Tuple of digits from the input alphabet (use 'omega' as ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inp","type":"<type 'str'>"},{"control_type":"input-box","default":"img","label":"Save to folder:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"folder","type":"<type 'str'>"},{"control_type":"input-box","default":7,"label":"Size of image:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_size","type":"<type 'int'>"},{"control_type":"input-box","default":"4","label":"Legend x-shift:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_legend_xshift","type":null},{"control_type":"input-box","default":"0","label":"Legend y-shift:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_legend_yshift","type":null},{"control_type":"input-box","default":"1","label":"Legend distance factor:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_legend_distance_factor","type":null},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡
︠d564c6d0-8302-4ac8-b001-33781909b93a︠








