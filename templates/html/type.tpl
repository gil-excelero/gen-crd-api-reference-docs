{{ define "type" }}

<h3 id="{{ anchorIDForType . }}">
    {{- .Name.Name }}
    {{ if eq .Kind "Alias" }}(<code>{{.Underlying}}</code> alias){{ end -}}
</h3>
{{ with (typeReferences .) }}
    <div class="alert alert-info col-md-8"><i class="fa fa-info-circle"></i> Appears In:
    <ul>
        <li>
                {{- $prev := "" -}}
                {{- range . -}}
                    {{- if $prev -}}, {{ end -}}
                    {{- $prev = . -}}
                    <a href="{{ linkForType . }}">{{ typeDisplayName . }}</a>
                {{- end -}}
        </li>
    </ul>
    </div>
{{ end }}

<div>
    {{ safe (renderComments .CommentLines) }}
</div>

{{ with (constantsOfType .) }}
<table>
    <thead>
        <tr>
            <th>Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
      {{- range . -}}
      <tr>
        {{- /*
            renderComments implicitly creates a <p> element, so we
            add one to the display name as well to make the contents
            of the two cells align evenly.
        */ -}}
        <td><p>{{ typeDisplayName . }}</p></td>
        <td>{{ safe (renderComments .CommentLines) }}</td>
      </tr>
      {{- end -}}
    </tbody>
</table>
{{ end }}

{{ if .Members }}
<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        {{ if isExportedType . }}
        <tr>
            <td>
                <code>apiVersion</code></br>
                <span class="type">string<span>
            </td>
            <td>
                <code>
                    {{apiGroup .}}
                </code>
            </td>
        </tr>
        <tr>
            <td>
                <code>kind</code></br>
                <span class="type">string<span>
            </td>
            <td><code>{{.Name.Name}}</code></td>
        </tr>
        {{ end }}
        {{ template "members" .}}
    </tbody>
</table>
{{ end }}

{{ end }}
