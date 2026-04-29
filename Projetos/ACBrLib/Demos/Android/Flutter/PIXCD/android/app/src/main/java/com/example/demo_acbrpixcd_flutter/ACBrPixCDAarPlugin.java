package com.example.demo_acbrpixcd_flutter;

import android.content.Context;

import androidx.annotation.NonNull;

import java.io.File;
import java.util.Date;

import br.com.acbr.lib.pixcd.ACBrLibPIXCD;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ACBrPixCDAarPlugin implements
        FlutterPlugin,
        MethodChannel.MethodCallHandler {
    // Padrão similar ao demo BAL: nome de canal simples e estável.
    private static final String CHANNEL_NAME = "acbrlib_pixcd_flutter";

    private MethodChannel channel;
    private ACBrLibPIXCD acBrLibPIXCD;
    private File appDir;
    private String arquivoConfig;
    private boolean initialized = false;
    private int initStatus = -1;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        Context context = binding.getApplicationContext();
        // Programação defensiva:
        // - Em alguns devices/ambientes, getExternalFilesDir pode retornar null.
        // - Não devemos lançar exceção aqui (não existe 'result' para reportar).
        // - Usamos fallback para um diretório privado interno do app.
        appDir = context.getExternalFilesDir(null);
        if (appDir == null) {
            appDir = context.getFilesDir();
        }

        arquivoConfig = new File(appDir, "ACBrLib.ini").getAbsolutePath();
        channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
        channel.setMethodCallHandler(this);

        acBrLibPIXCD = new ACBrLibPIXCD(arquivoConfig, "");
    }

    private int ensureInitialized() throws Exception {
        if (acBrLibPIXCD == null) {
            throw new IllegalStateException("ACBrLibPIXCD não instanciada");
        }
        if (initialized) return initStatus;

        // espelha o comportamento do demo Java: inicializa + aplica config padrão + lê INI
        initStatus = acBrLibPIXCD.inicializar();

        File logDir = new File(appDir, "logs");
        if (!logDir.exists()) {
            //noinspection ResultOfMethodCallIgnored
            logDir.mkdirs();
        }

        acBrLibPIXCD.configGravarValor("Principal", "LogPath", logDir.getAbsolutePath());
        acBrLibPIXCD.configGravarValor("Principal", "LogNivel", "4");
        acBrLibPIXCD.configGravar();
        acBrLibPIXCD.configLer(arquivoConfig);

        initialized = true;
        return initStatus;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
        if (acBrLibPIXCD != null) {
            try {
                acBrLibPIXCD.finalizar();
            } catch (Exception ignored) {
                // defensive: ignore finalize failures on detach
            }
        }
        initialized = false;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        try {
            // defensive: garantir que chamadas de config/comandos funcionem mesmo se o Dart não chamar inicializar()
            if (!"finalizar".equals(call.method) && !"inicializar".equals(call.method)) {
                ensureInitialized();
            }
            switch (call.method) {
                case "inicializar":
                    result.success(ensureInitialized());
                    break;
                case "finalizar":
                    result.success(acBrLibPIXCD.finalizar());
                    initialized = false;
                    initStatus = -1;
                    break;
                case "configGravar":
                    result.success(acBrLibPIXCD.configGravar());
                    break;
                case "configLer": {
                    String eArqConfig = call.argument("eArqConfig");
                    if (eArqConfig == null || eArqConfig.trim().isEmpty()) {
                        eArqConfig = arquivoConfig;
                    }
                    result.success(acBrLibPIXCD.configLer(eArqConfig));
                    initialized = true;
                    break;
                }
                case "configGravarValor": {
                    String sessao = call.argument("sessao");
                    String chave = call.argument("chave");
                    String valor = call.argument("valor");
                    if (sessao == null || chave == null || valor == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: sessao, chave, valor");
                    }
                    result.success(acBrLibPIXCD.configGravarValor(sessao, chave, valor));
                    break;
                }
                case "configLerValor": {
                    String sessao = call.argument("sessao");
                    String chave = call.argument("chave");
                    if (sessao == null || chave == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: sessao, chave");
                    }
                    result.success(acBrLibPIXCD.configLerValor(sessao, chave));
                    break;
                }
                case "convertDateToTDateTime": {
                    Number epochMillis = call.argument("epochMillis");
                    if (epochMillis == null) {
                        throw new IllegalArgumentException("Parâmetro obrigatório: epochMillis");
                    }
                    double tDateTime = acBrLibPIXCD.convertDateToTDateTime(new Date(epochMillis.longValue()));
                    result.success(tDateTime);
                    break;
                }
                case "GerarQRCodeEstatico": {
                    String valor = call.argument("valor");
                    String informacoesAdicionais = call.argument("informacoesAdicionais");
                    String txId = call.argument("txId");
                    if (valor == null || txId == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: valor, txId");
                    }
                    if (informacoesAdicionais == null) informacoesAdicionais = "";
                    double valorDouble;
                    try {
                        valorDouble = Double.parseDouble(valor.trim().replace(",", "."));
                    } catch (Exception e) {
                        throw new IllegalArgumentException("Valor inválido (esperado numérico): " + valor);
                    }
                    result.success(acBrLibPIXCD.GerarQRCodeEstatico(valorDouble, informacoesAdicionais, txId));
                    break;
                }
                case "CriarCobrancaImediata": {
                    String criarCobrancaImediata = call.argument("criarCobrancaImediata");
                    String txId = call.argument("txId");
                    if (criarCobrancaImediata == null || txId == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: criarCobrancaImediata, txId");
                    }
                    result.success(acBrLibPIXCD.CriarCobrancaImediata(criarCobrancaImediata, txId));
                    break;
                }
                case "RevisarCobrancaImediata": {
                    String revisarCobrancaImediata = call.argument("revisarCobrancaImediata");
                    String txId = call.argument("txId");
                    if (revisarCobrancaImediata == null || txId == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: revisarCobrancaImediata, txId");
                    }
                    result.success(acBrLibPIXCD.RevisarCobrancaImediata(revisarCobrancaImediata, txId));
                    break;
                }
                case "ConsultarCobrancaImediata": {
                    String txId = call.argument("txId");
                    Number revisao = call.argument("revisao");
                    if (txId == null || revisao == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: txId, revisao");
                    }
                    result.success(acBrLibPIXCD.ConsultarCobrancaImediata(txId, revisao.intValue()));
                    break;
                }
                case "CancelarCobrancaImediata": {
                    String txId = call.argument("txId");
                    if (txId == null) {
                        throw new IllegalArgumentException("Parâmetro obrigatório: txId");
                    }
                    result.success(acBrLibPIXCD.CancelarCobrancaImediata(txId));
                    break;
                }
                case "ConsultarCobrancasCob": {
                    Number tDateTimeInicial = call.argument("tDateTimeInicial");
                    Number tDateTimeFinal = call.argument("tDateTimeFinal");
                    String cpfCnpj = call.argument("cpfCnpj");
                    Boolean location = call.argument("location");
                    Number status = call.argument("status");
                    Number pagAtual = call.argument("pagAtual");
                    Number itensPorPagina = call.argument("itensPorPagina");
                    if (tDateTimeInicial == null || tDateTimeFinal == null || cpfCnpj == null || location == null || status == null || pagAtual == null || itensPorPagina == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: tDateTimeInicial, tDateTimeFinal, cpfCnpj, location, status, pagAtual, itensPorPagina");
                    }
                    result.success(acBrLibPIXCD.ConsultarCobrancasCob(
                            tDateTimeInicial.doubleValue(),
                            tDateTimeFinal.doubleValue(),
                            cpfCnpj,
                            location,
                            status.intValue(),
                            pagAtual.intValue(),
                            itensPorPagina.intValue()
                    ));
                    break;
                }
                case "CriarCobranca": {
                    String criarCobranca = call.argument("criarCobranca");
                    String txId = call.argument("txId");
                    if (criarCobranca == null || txId == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: criarCobranca, txId");
                    }
                    result.success(acBrLibPIXCD.CriarCobranca(criarCobranca, txId));
                    break;
                }
                case "RevisarCobranca": {
                    String revisarCobranca = call.argument("revisarCobranca");
                    String txId = call.argument("txId");
                    if (revisarCobranca == null || txId == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: revisarCobranca, txId");
                    }
                    result.success(acBrLibPIXCD.RevisarCobranca(revisarCobranca, txId));
                    break;
                }
                case "ConsultarCobranca": {
                    String txId = call.argument("txId");
                    Number revisao = call.argument("revisao");
                    if (txId == null || revisao == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: txId, revisao");
                    }
                    result.success(acBrLibPIXCD.ConsultarCobranca(txId, revisao.intValue()));
                    break;
                }
                case "ConsultarCobrancasCobV": {
                    Number tDateTimeInicial = call.argument("tDateTimeInicial");
                    Number tDateTimeFinal = call.argument("tDateTimeFinal");
                    String cpfCnpj = call.argument("cpfCnpj");
                    Boolean location = call.argument("location");
                    Number status = call.argument("status");
                    Number pagAtual = call.argument("pagAtual");
                    Number itensPorPagina = call.argument("itensPorPagina");
                    if (tDateTimeInicial == null || tDateTimeFinal == null || cpfCnpj == null || location == null || status == null || pagAtual == null || itensPorPagina == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: tDateTimeInicial, tDateTimeFinal, cpfCnpj, location, status, pagAtual, itensPorPagina");
                    }
                    result.success(acBrLibPIXCD.ConsultarCobrancasCobV(
                            tDateTimeInicial.doubleValue(),
                            tDateTimeFinal.doubleValue(),
                            cpfCnpj,
                            location,
                            status.intValue(),
                            pagAtual.intValue(),
                            itensPorPagina.intValue()
                    ));
                    break;
                }
                case "ConsultarPix": {
                    String e2eId = call.argument("e2eId");
                    if (e2eId == null) {
                        throw new IllegalArgumentException("Parâmetro obrigatório: e2eId");
                    }
                    result.success(acBrLibPIXCD.ConsultarPix(e2eId));
                    break;
                }
                case "ConsultarPixRecebidos": {
                    Number tDateTimeInicial = call.argument("tDateTimeInicial");
                    Number tDateTimeFinal = call.argument("tDateTimeFinal");
                    String txId = call.argument("txId");
                    String cpfCnpj = call.argument("cpfCnpj");
                    Number pagAtual = call.argument("pagAtual");
                    Number itensPorPagina = call.argument("itensPorPagina");
                    if (tDateTimeInicial == null || tDateTimeFinal == null || txId == null || cpfCnpj == null || pagAtual == null || itensPorPagina == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: tDateTimeInicial, tDateTimeFinal, txId, cpfCnpj, pagAtual, itensPorPagina");
                    }
                    result.success(acBrLibPIXCD.ConsultarPixRecebidos(
                            tDateTimeInicial.doubleValue(),
                            tDateTimeFinal.doubleValue(),
                            txId,
                            cpfCnpj,
                            pagAtual.intValue(),
                            itensPorPagina.intValue()
                    ));
                    break;
                }
                case "SolicitarDevolucaoPix": {
                    String solicitarDevolucaoPIX = call.argument("solicitarDevolucaoPIX");
                    String e2eId = call.argument("e2eId");
                    String idDevolucao = call.argument("idDevolucao");
                    if (solicitarDevolucaoPIX == null || e2eId == null || idDevolucao == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: solicitarDevolucaoPIX, e2eId, idDevolucao");
                    }
                    result.success(acBrLibPIXCD.SolicitarDevolucaoPix(solicitarDevolucaoPIX, e2eId, idDevolucao));
                    break;
                }
                case "ConsultarDevolucaoPix": {
                    String e2eId = call.argument("e2eId");
                    String idDevolucao = call.argument("idDevolucao");
                    if (e2eId == null || idDevolucao == null) {
                        throw new IllegalArgumentException("Parâmetros obrigatórios: e2eId, idDevolucao");
                    }
                    result.success(acBrLibPIXCD.ConsultarDevolucaoPix(e2eId, idDevolucao));
                    break;
                }
                default:
                    result.notImplemented();
                    break;
            }
        } catch (Exception e) {
            result.error("Erro", e.getMessage(), null);
        }
    }
}

