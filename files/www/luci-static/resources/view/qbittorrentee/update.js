'use strict';
'require view';
'require fs';
'require poll';
'require ui';

const updater = '/usr/libexec/qbittorrentee-update';

function execute(action) {
    return fs.exec(updater, [action]).then(function(result) {
        if (result.code !== 0) {
            throw new Error(result.stderr || result.stdout || '操作失败');
        }

        return result.stdout.trim();
    });
}

return view.extend({
    render: function() {
        const version = E('span', {}, '正在读取...');
        const status = E('p', {}, '正在读取更新状态...');
        const log = E('pre', {
            'style': 'margin: 0; padding: 1rem; min-height: 5em; max-height: 24em; overflow: auto; '
                + 'white-space: pre-wrap; overflow-wrap: anywhere; font-family: ui-monospace, Consolas, monospace; '
                + 'font-size: 0.8125rem; line-height: 1.65; border: 1px solid var(--lighter, #dee2e6); '
                + 'border-radius: 0.25rem; background: var(--background-color, #f4f5f7); color: inherit;'
        }, '正在读取更新日志...');
        let submitting = false;
        const button = E('button', {
            'class': 'cbi-button cbi-button-action',
            'disabled': true,
            'click': function() {
                submitting = true;
                button.disabled = true;
                status.textContent = '正在启动更新任务...';
                return execute('start').catch(function(error) {
                    ui.addNotification(null, E('p', {}, error.message), 'error');
                }).finally(function() {
                    submitting = false;
                    return refresh();
                });
            }
        }, '更新');

        function refresh() {
            return Promise.all([
                execute('status').then(function(value) {
                    const result = JSON.parse(value);
                    status.textContent = result.message;
                    button.disabled = submitting
                        || ['idle', 'done', 'error'].indexOf(result.state) === -1
                        || L.hasViewPermission() === false;
                }).catch(function(error) {
                    status.textContent = '无法读取更新状态：' + error.message;
                    button.disabled = true;
                }),
                execute('version').then(function(value) {
                    version.textContent = value.replace(/^qBittorrent\s+(?=v)/, 'qBittorrent Enhanced Edition ');
                }).catch(function(error) {
                    version.textContent = '无法读取：' + error.message;
                }),
                execute('log').then(function(value) {
                    const atBottom = log.scrollHeight - log.scrollTop - log.clientHeight < 32;
                    log.textContent = value.replace(/\r\n?/g, '\n');
                    if (atBottom) {
                        log.scrollTop = log.scrollHeight;
                    }
                }).catch(function(error) {
                    log.textContent = '无法读取更新日志：' + error.message;
                })
            ]);
        }

        poll.add(refresh, 5);
        refresh();

        return E('div', { 'class': 'cbi-map' }, [
            E('h2', {}, 'qBittorrent Enhanced Edition'),
            E('div', { 'class': 'cbi-section' }, [
                E('p', {}, ['当前版本：', version]),
                status,
                E('div', {
                    'style': 'padding: 0.75rem 1.25rem 1.25rem;'
                }, [button])
            ]),
            E('details', {
                'class': 'cbi-section', 'open': true, 'style': 'padding: 1rem 1.25rem;'
            }, [
                E('summary', {
                    'style': 'cursor: pointer; font-weight: 600; line-height: 1.5;'
                }, '更新日志'),
                E('div', { 'style': 'padding-top: 0.75rem;' }, [
                    E('p', {
                        'style': 'margin: 0 0 0.75rem; padding: 0; font-size: 0.875rem; opacity: 0.7;'
                    }, '每 5 秒自动刷新'),
                    log
                ])
            ])
        ]);
    },
    handleSave: null,
    handleSaveApply: null,
    handleReset: null
});
