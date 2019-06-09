let currentPage = 1

const paging = p => {
  const pageElement = document.getElementById('currentPage')
  switch (p.id) {
    case "firstPage":
      currentPage = 1
      break;
    case "prevPage":
      if (currentPage > +pageElement.min) currentPage--
      break;
    case "nextPage":
      if (currentPage < +pageElement.max) currentPage++
      break;
    case "lastPage":
      currentPage = +pageElement.max
      break;
    case "currentPage":
      currentPage = +pageElement.value
      break;
    case "pageSize":
      const max = +Math.ceil(total / p.value)
      document.getElementById('totalPage').textContent = `/ ${max}`
      pageElement.max = max
      currentPage = (currentPage > max ? max : currentPage)
      break;
  }
  pageElement.value = currentPage
  $.ajax({
    url: "/Home/Paging",
    data: { page: pageElement.valueAsNumber, pagesize: document.getElementById('pageSize').value },
    type: "post",
    dataType: "json",
    success: function (result) {
      let builder = ''
      result.forEach(element => {
        const nation = element.nations.filter(e => e.value == element.nationID)
        builder += `<tr><td>${element.name}</td><td>${element.bornYear}</td><td>${element.company}</td><td>${nation[0].text}</td><td>${element.asset}</td><td><a href="/Home/Update/${element.id}">Edit</a></td><td><form onsubmit="return confirm('Do you really want to remove this billionaire?')" method="post" action="/Home/Delete/${element.id}"><button>Remove</button></form></td></tr>`
      })
      $('tbody').html(builder)
    },
    error: function (data) {
      alert('error')
      console.log(data)
    }
});
}