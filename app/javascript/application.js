// Entry point for the build script in your package.json

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//= require Chart.min
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require Chart.bundle
//= require turbolinks
// = require_tree .
//= require highcharts