import React from 'react'
import ReactDOM from 'react-dom'

import TopPageViewsReport from "./top_pageviews_report"
import TopReferrersReport from "./top_referrers_report"

class ReportFramework extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      report: "top_pageviews",
    };
  }

  handleTabClick(report) {
    this.setState({report: report})
  }

  render() {
    let report

    if (this.state.report === "top_referrers") {
      report = <TopReferrersReport />
    } else {
      report = <TopPageViewsReport />
    }
      
    return (
      <div>
        <ul className="nav nav-tabs">
          <li role="presentation" className="active">
            <a href="#" onClick={() => this.handleTabClick("top_pageviews")}>Top PageViews</a>
          </li>
          <li role="presentation">
            <a href="#" onClick={() => this.handleTabClick("top_referrers")}>Top Referrers</a>
          </li>
        </ul>

        {report}
      </div>
    )
  }
}

export default ReportFramework
