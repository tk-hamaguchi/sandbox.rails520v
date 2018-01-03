const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

environment.loaders.append('vue', vue)

const fontawesome =  require('./loaders/fontawesome')
environment.loaders.append('fontawesome', fontawesome)

module.exports = environment
