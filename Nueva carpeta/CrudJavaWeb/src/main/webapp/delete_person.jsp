<%@page import="CrudJavaWeb.api"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<%
    String id = "";
    try {
        id = request.getParameter("cedula");
        //cliente
        HttpClient cliente = HttpClient.newHttpClient();
        //solicitud
        HttpRequest solicitud = HttpRequest.newBuilder()
                .uri(URI.create(api.getApi() + "?cedula=" + id))
                .DELETE()
                .build();
        //respuesta
        HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());
        response.sendRedirect("index.jsp");

    } catch (Exception e) {
        out.print("Error" + e);
    }
%>