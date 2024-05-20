<%@page import="CrudJavaWeb.api"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.*"%>
<!DOCTYPE html>
<html lang="es">
    <jsp:include page="head.jsp" />

    <body style="width: 80%; margin: auto;">
        <div>
            <jsp:include page="navbar.jsp" />
        </div>
        <form method="POST">
            <div class="mb-3">
                <label for="cedula" class="form-label">Cedula</label>
                <input type="text" class="form-control" id="cedula" name="cedula">
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre">
            </div>
            <div class="mb-3">
                <label for="apellido" class="form-label">Apellido</label>
                <input type="text" class="form-control" id="apellido" name="apellido">
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Direccion</label>
                <input type="text" class="form-control" id="direccion" name="direccion">
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Telefono</label>
                <input type="text" class="form-control" id="telefono" name="telefono">
            </div>
            <button type="submit" class="btn btn-primary">AGREGAR</button>
        </form>

        <%
            if (!(request.getMethod().equals("POST"))) {
                return;
            }
            String cedula = request.getParameter("cedula");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String postData = "cedula=" + cedula + "&nombre=" + nombre + "&apellido=" + apellido + "&direccion=" + direccion + "&telefono=" + telefono;
            //cliente
            HttpClient cliente = HttpClient.newHttpClient();
            //solicitud
            HttpRequest solicitud = HttpRequest.newBuilder()
                    //le hice una clase aparte la api pero puede estar en este mismo archivo
                    .uri(URI.create(api.getApi()))
                    .header("Content-Type", "application/x-www-form-urlencoded")
                    .POST(HttpRequest.BodyPublishers.ofString(postData))
                    .build();

            //respuesta del servidor
            HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());
            if (!(respuesta.statusCode() == 200)) {
                out.print("<br>");
                out.print("<div class='alert alert-danger'" + "role='alert'>Error al registrar</div>");
            } else {
                out.print("<br>");
                out.print("<div class='alert alert-success'" + "role='alert'>Registrado con exito</div>");
            }
        %>
    </body>

</html>
