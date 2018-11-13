import Vapor

final class FormPageController {

   // Variables
   var formName = ""      // form input for name
   var formMessage = ""   // form text box for message
   var formResponse = ""  // form response to send back


   // Routes

   // Displays form page at "form" route
   func displayFormPage(_ req: Request) throws -> Future<View> {
      if !formName.isEmpty {
         if !formMessage.isEmpty {
            formResponse = "\(formName) says '\(formMessage)'."
         } else {
            formResponse = "Hello, \(formName)!"
         }
      } else {
         formResponse = ""
      }
      return try req.view().render("form", [
         "response": formResponse
         ])
   }

   // Submits form page at "send" route and redirects to "form" route
   func submitFormPage(_ req: Request) throws -> Response {
      formName = try req.content.syncGet(at: "name")
      formMessage = try req.content.syncGet(at: "message")
      return req.redirect(to: "/form")
   }
}
