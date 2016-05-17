module.exports = {  
  entry: {
    component: "./web/static/js/app/containers/index.js",
  },
  output: {
    path: "./priv/static/server/js",
    filename: "reph_app.js",
    library: "reph_app",
    libraryTarget: "commonjs2"
  },
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: "babel",
      query: {
        plugins: ["transform-decorators-legacy"],
        presets: ["react", "es2015", "stage-2"],
      }
    }],
  },
  resolve: {
    extensions: ["", ".js", ".less", ".css"],
    modulesDirectories: ["node_modules", __dirname + "/web/static/js/app"],
    alias: {
      styles: __dirname + "/web/static/styles/app"
    }
  }
};