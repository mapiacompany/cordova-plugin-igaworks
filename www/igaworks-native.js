function IGAworksManager() {}  

IGAworksManager.prototype.startSession = function() {
  cordova.exec(null, null, "IGAworksManager", "startSession", []);
};

IGAworksManager.prototype.endSession = function() {
  cordova.exec(null, null, "IGAworksManager", "endSession", []);
};

IGAworksManager.prototype.setUserID = function(userID, s, f) {
  cordova.exec(s, f, "IGAworksManager", "setUserID", [userID]);
};

module.exports = new IGAworksManager();
