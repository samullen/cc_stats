import React from 'react'
import ReactDOM from 'react-dom'

class TopReferrersReport extends React.Component {
  constructor() {
    super()

    this.state = {
      data: { }
    };

    this.referrerTable = this.referrerTable.bind(this)
  }

  componentWillMount(props) {
    let init = { 
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
      cache: 'default' 
    };

    let request = new Request('/api/page_views/daily_top_referrers', init);

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

  referrerTable() {
    let rows = new Array
    let row = 1

    for (let date in this.state.data) {
      rows.push(
        <tr key={date} className="warning">
          <th colSpan='2' className="text-center"><h3>{date}</h3></th>
        </tr>
      )

      for (let url in this.state.data[date]) {
        let urlObject = this.state.data[date][url]
        
        rows.push(
          <tr key={`${date}-${url}`} className="info">
            <td>{url}</td>
            <td>{urlObject.visits}</td>
          </tr>
        )

        rows.push(urlObject.referrers.map((referrer, i) => {
          return (
            <tr key={`${date}-${url}-${i}`}>
              <td>- {referrer.url}</td>
              <td>{referrer.visits}</td>
            </tr>
          )
        }))
      }
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
    return (
      <div className="col-md-12">
        <h3>Top Referrers</h3>
        { this.referrerTable() }
      </div>
    )
  }
}

export default TopReferrersReport
