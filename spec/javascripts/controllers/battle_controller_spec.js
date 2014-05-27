describe("mocking ajax", function() {
  describe("suite wide usage", function() {
    beforeEach(function() {
      jasmine.Ajax.install();
    });

    afterEach(function() {
      jasmine.Ajax.uninstall();
    })

    xit("specifying response when you need it", function() {
      var doneFn = jasmine.createSpy("success");

      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function(arguments) {
        if (this.readyState == this.DONE) {
          doneFn(this.responseText);
        }
      };

      xhr.open('PUT', "update");
      xhr.send();

      expect(jasmine.Ajax.requests.mostRecent().url).toBe("update");
      expect(doneFn).not.toHaveBeenCalled();

      jasmine.Ajax.requests.mostRecent().response({
        "status": 200,
        "contentType": 'text/plain',
        "responseText": 'awesome response'
      })

      expect(doneFn).toHaveBeenCalledWith('awesome response')
    })
  })
})




//enter number, check against database,  display result, send info to server, your view updates stats,