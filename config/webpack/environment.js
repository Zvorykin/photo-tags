const { environment } = require('@rails/webpacker')
// const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

// use if update to vue-loader version >14
// but got conflict using Pug

// environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.append('vue', vue)
module.exports = environment
