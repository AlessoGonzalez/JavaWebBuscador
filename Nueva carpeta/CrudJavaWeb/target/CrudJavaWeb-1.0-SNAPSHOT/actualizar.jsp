<%@page import="CrudJavaWeb.api"%> 
<%@page import="java.net.URLEncoder"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<!DOCTYPE html>
<html lang="es">
    <jsp:include page="head.jsp" />

    <body style="width: 80%; margin: auto;">
        <div>
            <jsp:include page="navbar.jsp" />
        </div>
        <%
            String nombre = "", apellido = "", direccion = "", telefono = "", id = "";
            try {
                id = request.getParameter("cedula");
                //cliente
                HttpClient cliente = HttpClient.newHttpClient();
                //solicitud
                HttpRequest solicitud = HttpRequest.newBuilder()
                        .uri(URI.create(api.getApi() + "?cedula=" + id))
                        .GET()
                        .build();
                //respuesta
                HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());

                JSONArray jsonArray = new JSONArray(respuesta.body());

                JSONObject jsonObject = jsonArray.getJSONObject(0);

                nombre = jsonObject.getString("nombre");
                apellido = jsonObject.getString("apellido");
                direccion = jsonObject.getString("direccion");
                telefono = jsonObject.getString("telefono");

            } catch (Exception e) {
                out.print("Error" + e);
            }
        %>


        <h1>Actualizar Estudiante</h1>

        <form method="POST" autocomplete="off">
            <div class="mb-3">
                <label for="cedula" class="form-label">cedula</label>
                <input type="text" class="form-control" id="cedula" name="cedula" value="<%= id%>" >
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<%=nombre%>">
            </div>
            <div class="mb-3">
                <label for="apellido" class="form-label">apellido</label>
                <input type="text" class="form-control" id="apellido" name="apellido" value="<%=apellido%>">
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">direccion</label>
                <input type="text" class="form-control" id="direccion" name="direccion" value="<%=direccion%>">
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">telefono</label>
                <input type="text" class="form-control" id="telefono" name="telefono" value="<%=telefono%>">
            </div>

            <button type="submit" class="btn btn-primary">Actualizar</button>
        </form>
        <%
            if (!(request.getMethod().equals("POST"))) {
                return;
            }
            try {
                String cedula = request.getParameter("cedula");
                nombre = request.getParameter("nombre");
                apellido = request.getParameter("apellido");
                direccion = request.getParameter("direccion");
                telefono = request.getParameter("telefono");

                // Build the query string for the request
                String queryString = "cedula=" + cedula
                        + "&nombre=" + URLEncoder.encode(nombre, "UTF-8")
                        + "&apellido=" + URLEncoder.encode(apellido, "UTF-8")
                        + "&direccion=" + URLEncoder.encode(direccion, "UTF-8")
                        + "&telefono=" + URLEncoder.encode(telefono, "UTF-8");

                // Cliente
                HttpClient cliente = HttpClient.newHttpClient();
                // Solicitud
                HttpRequest solicitud = HttpRequest.newBuilder()
                        .uri(URI.create(api.getApi()))
                        .header("Content-Type", "application/x-www-form-urlencoded")
                        .PUT(HttpRequest.BodyPublishers.ofString(queryString))
                        .build();

                // Respuesta
                HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());

                if (!(respuesta.statusCode() == 200)) {
                    out.print("<br>");
                    out.print("<div class='alert alert-danger'" + "role='alert'>ERROR AL ACTUALIZAR EL REGISTRO</div>");
                } else {
                    out.print("<br>");
                    out.print("<div class='alert alert-success'" + "role='alert'>REGISTRO ACTUALIZADO CON EXITO</div>");
                }
                //Esto redirije automaticamente al index, quitarlo para que asomen los mensajes de actualizado
                response.sendRedirect("index.jsp");

            } catch (Exception e) {
                out.print(e.getMessage());
            }
        %>

    </body>
</html>