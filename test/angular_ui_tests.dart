// Copyright (C) 2013 - 2014 Angular Dart UI authors. Please see AUTHORS.md.
// https://github.com/akserg/angular.dart.ui
// All rights reserved.  Please see the LICENSE.md file.

library angular_ui_test;

import 'package:guinness/guinness_html.dart';
import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:angular/mock/test_injection.dart';

import 'package:angular_ui/utils/position.dart';
import 'package:angular_ui/utils/timeout.dart';
import 'package:angular_ui/utils/transition.dart';
import 'package:angular_ui/utils/content_append.dart';

import 'package:angular_ui/buttons/buttons.dart';
import 'package:angular_ui/alert/alert.dart'; 
import 'package:angular_ui/collapse/collapse.dart';
import 'package:angular_ui/dropdown/dropdown_toggle.dart';
import 'package:angular_ui/rating/rating.dart'; 
import 'package:angular_ui/timepicker/timepicker.dart';
import 'package:angular_ui/tooltip/tooltip.dart';
import 'package:angular_ui/pagination/pagination.dart';
import 'package:angular_ui/accordion/accordion.dart'; 

//import 'package:angular_ui/modal/modal.dart';

part 'unit/utils/position_test.dart';
part 'unit/utils/timeout_test.dart';
part 'unit/utils/transition_test.dart';
part 'unit/utils/content_append_test.dart';

part 'unit/buttons/checkbox_component_test.dart';
part 'unit/buttons/radiobutton_component_test.dart';
part 'unit/alert/alert_component_test.dart';
part 'unit/collapse/collapse_component_test.dart';
part 'unit/dropdown/dropdown_component_test.dart';
part 'unit/rating/rating_component_test.dart';
part 'unit/timepicker/timepicker_component_test.dart';
part 'unit/tooltip/tooltip_component_test.dart';
part 'unit/pagination/pager_component_test.dart';
part 'unit/pagination/pagination_component_test.dart';
part 'unit/accordion/accordion_component_test.dart';
part 'unit/accordion/accordion_group_component_test.dart';

//part 'unit/modal/modal_component_test.dart';

main(){
  guinnessEnableHtmlMatchers();

  testPosition();
  testTimeout();
  testTransition();
  testContentAppendComponent();
  
  testCheckboxComponent();
  testRadiobuttonComponent();
  testAlertComponent();
  testCollapseComponent();
  testDropdownComponent();
  testRatingComponent();
  testTimepickerComponent();
  testTooltipComponent();
  testPagerComponent();
  testPaginationComponent();
  testAccordionComponent();
  testAccordionGroupComponent();

//  testModalComponent();
  
  guinness.initSpecs();
}

loadTemplates(List<String> templates){
  updateCache(template, response) => inject((TemplateCache cache) => cache.put(template, response));

  final futures = templates.map((template) =>
    dom.HttpRequest.request('packages/angular_ui/' + template, method: "GET").
    then((_) => updateCache(template, new HttpResponse(200, _.response))));

  return Future.wait(futures);
}

compileComponent(String html, Map scope, callback){
  return async(() {
    inject((TestBed tb) {
      final s = tb.rootScope.createChild(scope);
      final el = tb.compile('<div>$html</div>', scope: s);

      microLeap();
      digest();

      callback(s, el);
    });
  });
}

digest(){
  inject((TestBed tb) { tb.rootScope.apply(); });
}