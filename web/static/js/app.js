// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import React from "react"
import ReactDOM from "react-dom"
import {DateField, DatePicker} from "react-date-picker"
import moment from "moment"






class MyDatePicker extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      calendar: moment().format("DD-MM-YYYY")
    };
  }

  updateDateString(datestring) {
    this.setState({calendar: datestring})
  }

  render(){
    return(
    <div>
      <input type="hidden" name="day" value={this.state.calendar} readOnly={true}/>

      <DateField
        dateFormat="DD-MM-YYYY"
        forceValidDate={true}
        updateOnDateClick={true}
        collapseOnDateClick={true}
        defaultValue={new Date()}
        showClock={false}
        onChange={(dateString, { dateMoment, timestamp}) => {this.updateDateString(dateString)}}
        >
        <DatePicker
          navigation={true}
          locale="es"
          updateOnWheel={false}
          forceValidDate={true}
          highlightWeekends={true}
          highlightToday={true}
          weekNumbers={false}
          weekStartDay={1}
          footer={false}
          />
      </DateField>

    </div>
  )
  }
};

if(document.getElementById("datepicker") != null){
  ReactDOM.render(
    <MyDatePicker/>,
    document.getElementById("datepicker")
  )
}
