<%inherit file="/base.mako"/>
<%block name="content">
% for host in hosts:
    <tr>
        <td>
            <input type="checkbox" value="">
        </td>
        <td class="ip">${ host['ip']}</td>
        <td>${ host['os']}</td>
        <td>${ host['bk_cloud_id']}</td>
    </tr>
% endfor
</%block>
