import React from 'react'
import ReactDOM from 'react-dom'

class TopPageViewsReport extends React.Component {
  constructor() {
    super()

    this.state = {
      data: { }
    };

    this.pageViewTable = this.pageViewTable.bind(this)
  }

  componentWillMount(props) {
    let init = { 
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
      cache: 'default' 
    };

    let request = new Request('/api/page_views/daily_top_urls', init);

    fetch(request,init).then((response) => {
      if (response.ok) {
        response.json().then((json) => {
          this.setState({data: json});
        });
      } 
      else {
        console.log('Network response was not ok.' + response);
      }
    })
    .catch((error) => {
      console.log("There was a problem fetching your lists: " + error.message);
    })
  }

  pageViewTable() {
    let rows = new Array
    let row = 1

    for (let date in this.state.data) {
      rows.push(<tr key={date}><td colSpan='2'>{date}</td></tr>)

      rows.push(this.state.data[date].map((pageview, i) => {
        return (
          <tr key={`${date}=${i}`}>
            <td>{pageview.url}</td>
            <td>{pageview.visits}</td>
          </tr>
        )
      }))
    }

    return (
      <table className="table table-hover">
      <tbody>
        {rows}
      </tbody>
      </table>
    )

  }

  render() {
    let somethign
    return (
      <div>
        <h1>Top PageViews</h1>
        { this.pageViewTable() }
      </div>
    )
  }
}

export default TopPageViewsReport
