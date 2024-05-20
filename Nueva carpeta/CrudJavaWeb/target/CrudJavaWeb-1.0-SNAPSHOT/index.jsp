<%@page import="CrudJavaWeb.api"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.net.http.HttpResponse.BodyHandlers"%>
<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<%@page import="java.net.URI"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <jsp:include page="head.jsp" />

    <body style="width: 80%; margin: auto;">
        <div>
            <jsp:include page="navbar.jsp" />
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">CEDULA</th>
                    <th scope="col">NOMBRE</th>
                    <th scope="col">APELLIDO</th>
                    <th scope="col">DIRECCION</th>
                    <th scope="col">TELEFONO</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
            </thead>

            <tbody>
                <%
                    //Cliente
                    HttpClient cliente = HttpClient.newHttpClient();
                    //Solicitud
                    HttpRequest solicitud = HttpRequest.newBuilder()
                            //le hice una clase aparte la api pero puede estar en este mismo archivo
                            .uri(URI.create(api.getApi()))
                            .GET()
                            .build();
                    //Respuesta
                    HttpResponse<String> respuesta = cliente.send(solicitud, BodyHandlers.ofString());

                    //USO DE DATOS
                    JSONArray jsonArray = new JSONArray(respuesta.body());
                    // Iterar a través del JSONArray e imprimir en la tabla
                    for (int i = 0; i < jsonArray.length(); i++) {
                        String cedula = jsonArray.getJSONObject(i).getString("cedula").toString();
                        String nombre = jsonArray.getJSONObject(i).getString("nombre").toString();
                        String apellido = jsonArray.getJSONObject(i).getString("apellido").toString();
                        String direccion = jsonArray.getJSONObject(i).getString("direccion").toString();
                        String telefono = jsonArray.getJSONObject(i).getString("telefono").toString();
                %>
                <tr>
                    <td><%= cedula%></td>
                    <td><%= nombre%></td>
                    <td><%= apellido%></td>
                    <td><%= direccion%></td>
                    <td><%= telefono%></td>
                    <td><a href="actualizar.jsp?cedula=<%= cedula%>" class="btn btn-primary">EDITAR</td>
                    <td><a href="delete_person.jsp?cedula=<%= cedula%>" class="btn btn-danger">ELIMINAR</td>
                </tr>
                <%
                    }
                %>

            </tbody>

        </table>
    </body>

</html>