using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ACBrLib.Core.CTe
{
    public enum ModalCTe
    {
        [EnumValue("01")]
        moRodoviario = 1,

        [EnumValue("02")]
        moAereo = 2,

        [EnumValue("03")]
        moAquaviario = 3,

        [EnumValue("04")]
        moFerroviario = 4,

        [EnumValue("05")]
        moDutoviario = 5,

        [EnumValue("06")]
        moMultimodal = 6
    }
}
