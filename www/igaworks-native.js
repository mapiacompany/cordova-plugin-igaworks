function IGAworksConnectPlugin() {}  

IGAworksConnectPlugin.prototype.setUserID = function(userID, s, f) {
  cordova.exec(s, f, "IGAworksConnectPlugin", "setUserID", [userID]);
};

IGAworksConnectPlugin.prototype.loadVideoAd = function (s, f) {
  cordova.exec(s, f, "IGAworksConnectPlugin", "loadVideoAd", []);
};

IGAworksConnectPlugin.prototype.showVideoAd = function (s, f) {
  cordova.exec(s, f, "IGAworksConnectPlugin", "showVideoAd", []);
};

IGAworksConnectPlugin.prototype.openOfferWall = function(s, f) {
  cordova.exec(s, f, "IGAworksConnectPlugin", "openOfferWall", []);
};

IGAworksConnectPlugin.prototype.setCashReward = function(s, f) {
  cordova.exec(s, f, "IGAworksConnectPlugin", "setCashReward", []);
};

IGAworksConnectPlugin.prototype.checkRequiredPermission = function(s, f) {
  cordova.exec(s, f, "IGAworksConnectPlugin", "checkRequiredPermission", []);
};

IGAworksConnectPlugin.prototype.openDialogTypeOfferWall = function(s, f) {
  cordova.exec(s, f, "IGAworksConnectPlugin", "openDialogTypeOfferWall", []);
};

module.exports = new IGAworksConnectPlugin();
