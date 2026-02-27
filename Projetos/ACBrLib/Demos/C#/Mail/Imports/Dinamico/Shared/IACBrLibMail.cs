using System;
using ACBrLib.Core;
using ACBrLib.Core.Mail;

namespace ACBrLib.Mail
{
    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrLib Mail.
    /// <para>
    /// Expõe montagem e envio de e-mails: assunto, destinatários (To, CC, BCC, ReplyTo),
    /// corpo, anexos, envio ou gravação em arquivo.
    /// </para>
    /// <para>
    /// Documentação geral: <see href="https://acbr.sourceforge.io/ACBrLib/">ACBrLib</see>
    /// Métodos Mail: <see href="https://acbr.sourceforge.io/ACBrLib/MetodosMail.html">Métodos Mail</see>
    /// </para>
    /// </summary>
    public interface IACBrLibMail : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da biblioteca ACBrLib Mail (sessão [Email] e demais).
        /// </summary>
        MailConfig Config { get; }

        /// <summary>
        /// Limpa os dados do e-mail em edição. Corresponde a MAIL_Clear.
        /// </summary>
        void Clear();

        /// <summary>
        /// Define o assunto do e-mail. Corresponde a MAIL_SetSubject.
        /// </summary>
        /// <param name="subject">Assunto do e-mail.</param>
        void SetSubject(string subject);

        /// <summary>
        /// Adiciona um destinatário. Corresponde a MAIL_AddAddress.
        /// </summary>
        /// <param name="eEmail">Endereço de e-mail.</param>
        /// <param name="eName">Nome de exibição.</param>
        void AddAddress(string eEmail, string eName);

        /// <summary>
        /// Adiciona endereço de resposta (Reply-To). Corresponde a MAIL_AddReplyTo.
        /// </summary>
        /// <param name="eEmail">Endereço de e-mail.</param>
        /// <param name="eName">Nome de exibição.</param>
        void AddReplyTo(string eEmail, string eName);

        /// <summary>
        /// Adiciona destinatário em cópia (CC). Corresponde a MAIL_AddCC.
        /// </summary>
        /// <param name="eEmail">Endereço de e-mail.</param>
        /// <param name="eName">Nome de exibição.</param>
        void AddCC(string eEmail, string eName);

        /// <summary>
        /// Adiciona destinatário em cópia oculta (BCC). Corresponde a MAIL_AddBCC.
        /// </summary>
        /// <param name="eEmail">Endereço de e-mail.</param>
        /// <param name="eName">Nome de exibição.</param>
        void AddBCC(string eEmail, string eName);

        /// <summary>
        /// Adiciona o corpo do e-mail. Corresponde a MAIL_AddBody.
        /// </summary>
        /// <param name="eBody">Texto ou HTML do corpo.</param>
        void AddBody(string eBody);

        /// <summary>
        /// Adiciona o corpo alternativo (texto puro). Corresponde a MAIL_AddAltBody.
        /// </summary>
        /// <param name="eAltBody">Texto alternativo.</param>
        void AddAltBody(string eAltBody);

        /// <summary>
        /// Remove todos os anexos. Corresponde a MAIL_ClearAttachment.
        /// </summary>
        void ClearAttachment();

        /// <summary>
        /// Adiciona um anexo ao e-mail. Corresponde a MAIL_AddAttachment.
        /// </summary>
        /// <param name="eFileName">Caminho do arquivo.</param>
        /// <param name="eDescription">Descrição do anexo.</param>
        /// <param name="aDisposition">Tipo de disposição (anexo ou inline).</param>
        void AddAttachment(string eFileName, string eDescription, MailAttachmentDisposition aDisposition);

        /// <summary>
        /// Envia o e-mail. Corresponde a MAIL_Send.
        /// </summary>
        void Send();

        /// <summary>
        /// Salva o e-mail montado em arquivo. Corresponde a MAIL_SaveToFile.
        /// </summary>
        /// <param name="eFileName">Caminho do arquivo de saída.</param>
        void SaveToFile(string eFileName);
    }
}
