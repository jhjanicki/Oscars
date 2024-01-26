artoo.scrape('.awards-result-chron', {
  year: {
    sel: '.result-group-header .result-group-title .nominations-link'
  },
  nominated: ($, [el]) => {
    const $els = $(el).find('.subgroup-nominee-chron')
    const nominations = $els.map((index, el) => {
      const $el = $(el)
      const name = $el.find('.result-subgroup-title .nominations-link').text()
      const category = $el.find('.awards-result-awardcategory-exact .nominations-link').text()
      const $productions = $el.find('.awards-result-film')
      const productions = $productions.map((index, el) => {
        const $el = $(el)
        const title = $el.find('.awards-result-film-title .nominations-link').text()
        const role = $($el.siblings('.awards-result-character').get(index)).text().trim().replace('{"', '').replace('"}', '').replace(';', '')
        const res = {
          title
        }
        if (role.length) {
          res.role = role
        }
        return res
      }).get()
      const won = !!$el.find('.glyphicon-star').length
      return {
        name,
        category,
        won,
        productions
      }
    })
    return nominations.get()
  },
}, artoo.savePrettyJson);