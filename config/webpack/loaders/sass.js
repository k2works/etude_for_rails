const ExtractTextPlugin = require('extract-text-webpack-plugin')

module.exports = {
  test: /\.(scss|sass|css|pcss)$/i,
  use: ExtractTextPlugin.extract({
    fallback: 'style-loader',
    use: ['css-loader', 'postcss-loader', 'sass-loader']
  })
}

module.exports = {
    test: /\.(scss|sass|css|pcss)$/i,
    loaders: [
        'style-loader',
        'css-loader?modules=true&localIdentName=[name]__[local]___[hash:base64:5]',
        'postcss-loader?modules=true&localIdentName=[name]__[local]___[hash:base64:5]',
        'sass-loader?modules=true&localIdentName=[name]__[local]___[hash:base64:5]'
    ],
}