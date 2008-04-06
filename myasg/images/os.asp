<%

'/**
' * ASP Stats Generator - Powerful and reliable ASP website counter
' *
' * This file is part of the ASP Stats Generator package.
' * (c) 2003-2008 Simone Carletti <weppos@weppos.net>, All Rights Reserved
' *
' * 
' * COPYRIGHT AND LICENSE NOTICE
' *
' * The License allows you to download, install and use one or more free copies of this program 
' * for private, public or commercial use.
' * 
' * You may not sell, repackage, redistribute or modify any part of the code or application, 
' * or represent it as being your own work without written permission from the author.
' * You can however modify source code (at your own risk) to adapt it to your specific needs 
' * or to integrate it into your site. 
' *
' * All links and information about the copyright MUST remain unchanged; 
' * you can modify or remove them only if expressly permitted.
' * In particular the license allows you to change the application logo with a personal one, 
' * but it's absolutly denied to remove copyright information,
' * including, but not limited to, footer credits, inline credits metadata and HTML credits comments.
' *
' * For the full copyright and license information, please view the LICENSE.htm
' * file that was distributed with this source code.
' *
' * Removal or modification of this copyright notice will violate the license contract.
' *
' *
' * @category        ASP Stats Generator
' * @package         ASP Stats Generator
' * @author          Simone Carletti <weppos@weppos.net>
' * @copyright       2003-2008 Simone Carletti
' * @license         http://www.weppos.com/asg/en/license.asp
' * @version         SVN: $Id: login.asp 13 2007-08-03 13:05:34Z weppos $
' */
 
'/* 
' * Any disagreement of this license behaves the removal of rights to use this application.
' * Licensor reserve the right to bring legal action in the event of a violation of this Agreement.
' */


const ASG_STR_ICON_HEX_UNKNOWN_OS = "47494638396114001400C4000086A5D6C5DDF1BFCDD87091CCD9E2EAD3E5F3476EBED5DDE3E2E9EECCE2F2CBD3DABFD8ECBFD2E1BFD5E5A6C2E5EEF1F4C0DAEEE9EDF0BFD0DCCCD9E3BFD6E8FCFDFDB3CDE9C2CCD3CEDEEB9AB8DEA2BEE2F1F4F7CAD6E0BFD1DF234EB0FFFFFF21F90400000000002C00000000140014000005D5E0278E646992D51611C741204F758A1B421478916013B19D9B5B4E97480420934829380C6834968074C1798C2A8821C0C3F5181C1048E320FB6C30B984A1CB3540160B89F283C014135BAFA3AB59503A042207770916190019035D16140D0C0A221C5293528A5C008D8E179194611A5D988E0C1D9B1F1361A80B196D8D0CA312901F040D70B5890300A21D12020722111D7014C39606AEBB12177315070C990DC51DC8BD651F0F0A0CA2AEAF12BC0A5624110A12C7C8DD020A73250F070202DDBC021707E0271511070A17170A0711D53302960801003B"

const ASG_STR_ICON_HEX_BLANK = "47494638396114001400800000FFFFFF00000021F90400000000002C0000000014001400000211848FA9CBED0FA39CB4DA8BB3DEBCFBAF15003B"


'/**
' * Returns Hex string for requested Operating System
' * 
' * If the function is unable to find a match
' * the unknown/transparent icon is returned.
' * ASG_STR_ICON_HEX_UNKNOWN_OS holds current unknown icon hex.
' * 
' * Identified icons:
' * 
' * __ microsoft windows
' *   \__ (strict)  microsoft windows vista
' *   \__ (strict)  microsoft windows 2003
' *   \__ (strict)  microsoft windows xp
' *   \__ (strict)  microsoft windows 2000
' *   \__ (strict)  microsoft windows ce
' *   \__ (strict)  microsoft windows nt 4
' *   \__ (strict)  microsoft windows nt 3
' *   \__ (instr)   microsoft windows nt
' *   \__ (strict)  microsoft windows me
' *   \__ (strict)  microsoft windows 98
' *   \__ (strict)  microsoft windows 95
' *   \__ (strict)  microsoft windows 3.1
' * __ mac os
' *   \__ (strict)  mac os 10
' *   \__ (instr)   mac os
' *   \__ (instr)   macintosh
' * __ linux
' *   \__ (strict)  linux
' * __ be os
' *   \__ (strict)  be os
' * __ sun os
' *   \__ (instr)   sun os
' * __ os/2
' *   \__ (strict)  os/2
' * __ riscos
' *   \__ (strict)  riscos
' * __ amiga
' *   \__ (instr)   amiga
' * __ bsd
' *   \__ (strict)  openbsd
' *   \__ (strict)  freebsd
' *   \__ (strict)  netbsd
' *   \__ (instr)   bsd
' * __ irix 
' *   \__ (instr)   irix
' * __ hp-ux
' *   \__ (instr)   hp-ux
' * __ java
' *   \__ (instr)   java
' * __ aix
' *   \__ (instr)   aix
' * __ symbian
' *   \__ (strict)  symbian
' * __ unix
' *   \__ (strict)  unix
' * __ mobile
' *   \__ (strict)  alcatel mobile
' *   \__ (strict)  motorola mobile
' *   \__ (strict)  nokia mobile
' *   \__ (strict)  sonyericsson mobile
' * __ robot
' *   \__ (strict)  robot
' * 
' * 
' * @param  string  os
' * @return string  
' */
public function getOsIconHex(os)

    strValue = lcase(trim(os))


    ' (Unknown)
    if strValue = "(unknown)" then
        strHex = ASG_STR_ICON_HEX_BLANK


    '*
    '* Microsoft Windows
    '* -----------------

    elseif strValue = "microsoft windows vista" then
        strHex = "47494638396114001400C40000085E96F6F4F334576C5C87A1C95F38EAA72B6388587F99B15DA7D1466F92B7C1CA7D53582D83A8A5C857DDE491F2D5729FBCD10D426E8FAD600A93D015B2E7FBCD380A7DB805A4DFCED5DBE5DFDC3D8BC7BBD2E5E7E9ECB395373FB1D9FFFFFF21F90400000000002C00000000140014000005DDE0278E626092281A1C6C7B4029A90C897BD003164351E2FF095A42A0934504C88512C914448A9F8033125910AE8B29B517101DB65642A1B090189854852801168F0D8D86793A886AAFE28EC121376C13011C110054090C030702127C0D7E85191C0084001A081B1C07069A9A923D19016C0009951010070E0F0D050692A21C1F03920CA308030D0F0F150509AD035D10AD0016B315C5051DC2920A5D010CC216D00C636FD0000319231BD013DCDC0C060C1613C3CB32E21317141417ECDEE5281B08E8EAEA171308EF290110081EFE1E08207C8A412250868327508400003B"

    elseif strValue = "microsoft windows 2003" then
        strHex = "47494638396114001400C40000D8AF0FF294505F8E0C3142DCD4D0A9B89C1EF469117BBC0A94A956CCCDC7F8CB135875F49F7E0EBAC49D90A9FCF7F8FCEFC574F3E9D3DFE1EFB5B5CDF7F5EBAFB47FD1B5A2ACBDF1BC370D7A90EDF8CDACEEEEF294D720E0D8D3FEFEF9FEFEFE21F90400000000002C00000000140014000005D8E0278A54A469D4A8AEDFA3414160041DCB6AB36C6058E4D92348CEB0C334048454A94118C562C50A42203870AE828628322C5AA8D5EB4120F97870D0E2B16AE51C101B91ECB96354A86D77E561264C2E8017015F6C6202096612190E0E190B03191B53616E08651F0E0B8C8E0303040D0D08A2A2097C0F198B998F19050C0010B01000351F129A8D8F0313AD05000ABF05B417B79C030D0CBDBE0A001571989A8E8F0B15C8CACB7B22A813DB1990BCD6058824141EE51E1D090CAEE009CE6623E60405C900051312EE400F1D040909127C80B07840904508003B"

    elseif strValue = "microsoft windows xp" then
        strHex = "47494638396114001400C40000D8AF0FF294505F8E0C3142DCD4D0A9B89C1EF469117BBC0A94A956CCCDC7F8CB135875F49F7E0EBAC49D90A9FCF7F8FCEFC574F3E9D3DFE1EFB5B5CDF7F5EBAFB47FD1B5A2ACBDF1BC370D7A90EDF8CDACEEEEF294D720E0D8D3FEFEF9FEFEFE21F90400000000002C00000000140014000005D8E0278A54A469D4A8AEDFA3414160041DCB6AB36C6058E4D92348CEB0C334048454A94118C562C50A42203870AE828628322C5AA8D5EB4120F97870D0E2B16AE51C101B91ECB96354A86D77E561264C2E8017015F6C6202096612190E0E190B03191B53616E08651F0E0B8C8E0303040D0D08A2A2097C0F198B998F19050C0010B01000351F129A8D8F0313AD05000ABF05B417B79C030D0CBDBE0A001571989A8E8F0B15C8CACB7B22A813DB1990BCD6058824141EE51E1D090CAEE009CE6623E60405C900051312EE400F1D040909127C80B07840904508003B"

    elseif strValue = "microsoft windows 2000" then
        strHex = "47494638396114001400C400008C8788A6C8E0F4F9F9EE6234154E97F2A18B5C655CF6D5CABABCBA6AF42E1618108EB7D676A0C6FBE0D6D4E4F14E87B6F38265EDF3F2E4E5E2C9D5DFE4EEF548280B32463C3179B37E4E0DFCEAE1F7BFB0FFE106FFFFFDFEFFFFFEFEFCFFFFFF21F90400000000002C00000000140014000005FF60E430CFC5044E2408113505CC751157F42EC144ADBC782F0F422420F8183F1C8FD2C3691E19C205A51991703ECBACE703D52C229C4E0681881C8F4A2E01426C660E0803808C98148D50888329911C3405060A838300665005141E1D13087F05100A180315160A16120B171A111E022E0000811503030A09090A0840079D9F0E01069615B41609821E010F073B130EB0BA0A250A950A001F30077B127301B1169A161B180A12C80C1A761FCC1682341603D30646BA0576571F711696C4D408E40FE60249E89E120896164C1F9A0565494A9AA0FB10CA0ABF355F006A598445C0162803BE7CE840B1A245231DD40C0070A081C70C20417A1CE911008152A5200B1458B912020494302F8400003B"

    elseif strValue = "microsoft windows ce" then
            strHex = "47494638396114001400C400005D5D5DD1A87EB6B4B4F3A752DFC19D5D94C8E7603A88A86882B1D9CED0CEE8E9E9FAD546E6993DFAF9F8F2C32D72A14A91C3F18AC452C0C18AF3D6C1EDE2D8F4F0E7A0B486868686456AADD4E2BC8A9FB7454545B9D5E6EDEFF29E9E9EFFFFFF21F90400000000002C00000000140014000005F1E0278E8A709D97A08C2CAB78C0266F80B7B6A3005C5942292F004080FB7836820961591135041B4F0B9A200C180643A0D210258624646370CD060E964C4662B1AC3AB0068551D63E1E91BCC5E3E9E8A40474590616787907093A261B091F0401020201678611070A091B271B0A1D0810080505090795160D0A9A171B1D1C0510A218124B12B52BA99B09089F051805010C0E0B0B0E141F9929439FA1181A0C0CC30B034D3002701A0508D81802C1C30E040D0D351D1F0A17091D0DADC0C2C412259C398C23158F0B01041450442C47025D3EC89940A10214293874D4480024010C3045CCC19841C3464412265058C31102003B"

    elseif strValue = "microsoft windows nt 4" then
        strHex = "47494638396114001400C40000A7A9ABD7670DC7CBD0678FC3D4D8E3F7F8FA1A1D1EA2B3CCF8E407EAEBF24A4D51717376EA9B6AE5B79EB8C0CA675F2A809875E9C5B5CCD2E0567398A0D274E3E5EDEAD4C9EEF0F5DADEE99E7D3C532C06353735C1CCDFFEFEFE000000FFFFFF21F90400000000002C00000000140014000005F4E0F77545D18968AA8A45856157B1CEDF45388244C4273D62040BC051D15512894BCC842A4830160B6401C03C093A5D8299E0442A9106606150281667408540A874309CA025C26064368A87C653065C304E120002610D760619010106100F1E0B185D7100100D860A1B8A1A1B141406062E1C090E1C0066640F9A1014108F45047107B26865067CAB8E6C82A4B207037803037977654E400043C1030613C10A0808191E006D0556A60B131B1BCD79D00F061712322D1C120B1B9F1E7C19D0AE183D055D2F0E0E94981B7B121217291D172EB0EC9320608307053664ACE840A200400909A81048D0C3C7081B400059F4278F878810003B"

    elseif strValue = "microsoft windows nt 3" then
        strHex = "47494638396114001400C40000F4F4F5D3D3D3289529141D1FA2A1FBFCA9A9FC18187474011111EDFECECEA5A4A56A6B69C9C9FDFE6F6F6D6DFD12491467679B9B6161A38E8F4432070C11A27E807D9191AC4C4C4FB50000FFFF013B3F3BC1C2C4B8B8B8EFEFEF000000FFFFFF21F90400000000002C00000000140014000005ADE0278E64699E68AAAE65A02C8B1290414D029CE6EDBC06889DC0A652595C2E8309063310081E9E8E2891280424928B446330309D50E9A7436D980D11AEB7F98C4EAB85823932E8321F6D712D206FA02F133C13816E1F004244464814080813191907850C941B161617101A8D148F91851D940EA3089A8D8E909262A104ADA310030814031E1307AA221B3504A410481E03C13C628743451A48151CC41C0B6223011C4301CF253F2CD8D9DA2621003B"

    ' Includes all NT versions not previously matched
    elseif InStr(strValue, "microsoft windows nt") > 0 then
        strHex = "47494638396114001400C40000F4F4F5D3D3D3289529141D1FA2A1FBFCA9A9FC18187474011111EDFECECEA5A4A56A6B69C9C9FDFE6F6F6D6DFD12491467679B9B6161A38E8F4432070C11A27E807D9191AC4C4C4FB50000FFFF013B3F3BC1C2C4B8B8B8EFEFEF000000FFFFFF21F90400000000002C00000000140014000005ADE0278E64699E68AAAE65A02C8B1290414D029CE6EDBC06889DC0A652595C2E8309063310081E9E8E2891280424928B446330309D50E9A7436D980D11AEB7F98C4EAB85823932E8321F6D712D206FA02F133C13816E1F004244464814080813191907850C941B161617101A8D148F91851D940EA3089A8D8E909262A104ADA310030814031E1307AA221B3504A410481E03C13C628743451A48151CC41C0B6223011C4301CF253F2CD8D9DA2621003B"
        
    elseif strValue = "microsoft windows me" then
        strHex = "47494638396114001400C40000EDDA07F1F5F66ECA65C57A1A87D181B2C8D7CEEBCE090D0ACFD0D0ADDCA69C9C9C74706F6599C4EDC69C26B338B7E2B6348049DAAE8F51BC66407FB69DD795ECEDE8255526DEE9E5F2D6C2372A193D46503CC0374FA93DCCDBEC5BC64DFFFFFF21F90400000000002C00000000140014000005EFA02010244125C963AC5755055F5C8E626D8B441C504FEFA3098A9042F00874944AEC53412C9F1F814447B82C9B0A2B544A355C3191C54241562008125880E0FD202A184C6391A91F0E1908F5114320E40D11190303191616070A1F0102098B1705646183851C02070B8B8D4C171D050B1A75A21E1C07059A1401089D05050C1913137886075E8C146E66AD1A1A0C1319000307167C8C396E62741A131A03C1070E8EC64B010ABC1977C0861BD22230D41517080AD80714DC9A02DF504BA017E88C1E5AEC5706F0021E6D5001060F441BF7F2C5A86080083E800E1C6C90D0CD0389831B124A9440A0C08500011A8400003B"

    elseif strValue = "microsoft windows 98" then
        strHex = "47494638396114001400C40000A8AAACD7670DF6F9FC6490C8C4CEDB1A1D1E9DB3D3F8E407D5DBE44B4D50707275EA9B6AE5B79EB9C1CCF0F5FA675F2A819578E9C5B5657E9F9CCF6FEAD4C9EBF0F59E7D3C532C06E6E9EF373A39EAE0DB30302B405579AEDA84000000FFFFFF21F90400000000002C00000000140014000005C1E0278E64698EC2A9A20D92AE2646014DF5C29F805014A4001887E0751B55229A0803A02824120A28A05242EC2891C5C2B2493C2E1E2740401510000425635BB0040205C8C3A3A05608080084B14E64DE17191D1305055408180D674F0A1B0F80101310744308780698514E85711373080E153404980603190903031C0F16194E460034AA120512AA090707161E63B15012191BB7ACBA0F8625770AAF051E6116BA94260E0E080D0D7A7E1B6004452643430D191E090E3824433FE6E72442EC3821003B"

    elseif strValue = "microsoft windows 95" then
        strHex = "47494638396114001400C400005B89BB9FB7CC141919C16733536066D8D1CFB8C8D571B95FF6FAFDF285445B7288D4B4A4D4E5F3C9DBE9899AA887A7C681868BA4851A244D1AFEE14D432C0BB7ACAAE5ECF126313BEAF1F7FFDC1DBB9988A9DC93404A4E716633000000FFFFFF21F90400000000002C00000000140014000005D0E0278E64698ED8A98E081020EB89058AD33031691501C1298686F0C680950A854A4571115C9E4EC203376A200B0B0D84201050289E30818A30540C8BACA6E3E924060289C47349311A068843A31934136F02070773011F01783D1C8B5E030314041B074E0C0C880601010E1C4D4D021E1C076C10089A01980F0F004E0000175F5D02051F0C0E3501A9041E0AAA021119111E0446180F3E104C17AD0A141313C10E2465104D1E9F9F1D13194E0D2616015B3E1761146C0A292708183B069B610286391FEA79021C46F222160F06F93921003B"

    elseif strValue = "microsoft windows 3.1" then
        strHex = "47494638396114001400C400006B6C6DF2F0F2F3F302CFD0D08B8689FB4A4A1321105959F6FED4D4D0D0F7FD01010909FBB1B3B2B0B0FF990102FEAFAF000099FC8383B647475A01014F4D018888FF00005E024F028B8B02028C024040A53E413E9292CEA1A1A1000000FEFEFE21F90400000000002C00000000140014000005C4E0278E64699E65A0A267307400C10CE23004E640185EEF1B36DD80D161100006DE6462B85C781D84B443D820011B8942E1306432174F278088201E914841E2D172BD60B1F4FC28A8ABEEEE373C2EA3D36B6D5C4C4D5043030F7F05551B3F1414501F014558581B061A100B101402021862090D0D360455551A0B9B9D9F62920D151507150B1A98AA9C9EA01DA20D0909B1071C1BA90B16ACBB1FBFB20707B598163ED21D4304BF1C1C07583C1B045448AE1F3A950697D426E7222A360C382CEFF0F12821003B"


    '*
    '* Mac OS
    '* -----------------

    ' Mac OS 10 == Mac OS X
    elseif strValue = "mac os 10" then
        strHex = "47494638396114001400C40000959595ABABABD2D2D2F1F1F1797979FDFDFDFAFAFABCBCBCECECEC717171858585E9E9E9CBCBCB6161616D6D6DDADADADDDDDD7C7C7C818181666666898989A0A0A0F5F5F58E8E8EE2E2E26A6A6A515151767676A5A5A5C3C3C35D5D5DFFFFFF21F90400000000002C00000000140014000005C8E0278EE467314BA99688423C6B5CB8D710AF43A2C0F758188541E03158580A3103E2211040208C8A24C131A80C904E601BE000149189E68024090215C085C2068B153692E172514822F848A2E1C96054080E11041B09090E130D890A56250B8A0D918A13191913118D24030D1A1A8A190E8687133C720A1A1E13A11B84850E19022A1DA80E1B11127711858A9922030E1E09110A6D771B0D15652407C112C474147704082B06150E12001C5D1517040CCA25160701020808185A02E12A0B1003053FEE713DF52221003B"

    elseif InStr(strValue, "mac os") > 0 then
        strHex = "47494638396114001400C40000F92A1DF9FAF5FD721E184ACE188C0E9C285EAFD6AA3F6FDDB3C7F0EDAC9BFFCB23F7D2CCF1D960D3E3F1C7B11DF6615BD8768A93AFEDE6F3E5C4D6ED82C17AE0EAF444A438BE1D46F2F4F4D9ECD5CAD791BEAD15678EE3FC9081FFFFFFFCFCFC21F90400000000002C0000000014001400000592A0278EA4874555E97D6CEB7E0685BDB4EB198455EF9E641186D5EE53C2510244E1AB47B15828B1E633A364F57E84AC566B91543D8C8D634C2E6B90AE8062CD6E2B1855E24240AFDB05099A6701E8FBFF001D717B80850F01711F85851D7A0F8B8010710B1795969795098310059D9E9F053334150703A6A7A71389440D07071C080811AE085F251513A201B8182ABEBF2421003B"

    ' Macintosh should use the same icon as Mac OS
    ' I need to check which is the difference within WBStat
    ' because Mac OS is the OS, Macintosh the architecture
    elseif InStr(strValue, "macintosh") > 0 then
        strHex = "47494638396114001400C40000F92A1DF9FAF5FD721E184ACE188C0E9C285EAFD6AA3F6FDDB3C7F0EDAC9BFFCB23F7D2CCF1D960D3E3F1C7B11DF6615BD8768A93AFEDE6F3E5C4D6ED82C17AE0EAF444A438BE1D46F2F4F4D9ECD5CAD791BEAD15678EE3FC9081FFFFFFFCFCFC21F90400000000002C0000000014001400000592A0278EA4874555E97D6CEB7E0685BDB4EB198455EF9E641186D5EE53C2510244E1AB47B15828B1E633A364F57E84AC566B91543D8C8D634C2E6B90AE8062CD6E2B1855E24240AFDB05099A6701E8FBFF001D717B80850F01711F85851D7A0F8B8010710B1795969795098310059D9E9F053334150703A6A7A71389440D07071C080811AE085F251513A201B8182ABEBF2421003B"


    '*
    '* Linux
    '* -----------------

    elseif strValue = "linux" then
        strHex = "47494638396114001400C400009C855FE8D8ADF3B908CC970DAEADAD6D6C6AFBC50E8F8E8BA27E31D6D6D6C6C4C37B5E12FCFCFA585757D2B15BE6E6E72C2D2FDAAF31DCAF0BB58407F2F4FB141314EDEEF1F6F6F64C370A75663FF5F4EFC6B79BAC9E7C3E3E40010307FEFEFE21F90400000000002C00000000140014000005C2E0278E62721C09A9AE8AE742C42A7F8DFB5AB3DA345501798A1CA950C8103D31A1A83031481648E5722089643C0569A2A1E0242C15A0B213A3886A1DDCEC507930DE16822B3B831C3E0C51BEE0A9A4586D1F177922072E772B1D1D221A782272582B140B19171F8D790C1C732A010E4E0D166F2201131E180E6623110202060B109679010313557F780EADAD19AA0919AE0606117F1703ADC20305073518AE02031C0F7A1B000813030B158A1D1803030804AA2316090400281A17170A0000B81F21003B"


    '*
    '* BeOS
    '* -----------------

    elseif strValue = "beos" then
        strHex = "47494638396114001400C4000089A7DB4478C87A9ED9CED9EE5382CD185BBF2866C1B8CAEAFBFBFC97B4E12F6BC4A3BBE36C94D53A71C60F51B90041B2638DD2E3EAF6F3F4FAEFF0F71E5EC0195BBD0A51BA024BB8094FB7FFFEFD1A5EBE165ABD0046B5024AB60B52B9064EB921F90400000000002C00000000140014000005FFA04169E3486AE8596AC6867D70FC5998F7D9F6BD6D577F753D18CD32C3586C054A434131341A9420CD93F358929043E400010C0E864B91EA316A2A0F4206F0E0043283CDC708AB7950EE35E7D33964141D42311E151A79007B7D08611F89811F6779020F0F0A1300811D040200047B786F070C0007040F7C020B4E03101D1B151D6F0B0D04A4A60D12010E0E07133B14926D1C0B080D02130C0C020909143BB17A8D0D19CC037B7C9F866F88161CD30900111B8F1D1E3B0F6F931C0F0919046F091D0F1D020A1B14010B19A5100B12007CDA0D200580108564042028AB17C8C205020916B482348EC3050E1D30969B838183C6391A3694A152C30E991A37CA106C6811724381573B2AECD87046268B10003B"


    '*
    '* Sun OS / Solaris
    '* -----------------

    elseif InStr(strValue, "sun os") > 0 then
        strHex = "47494638396114001400C4000055568F8383ADCCCCDD8D8DB4B3B3CD9696B97E7FAABCBCD29E9EBEA0A0C06566997272A27A7AA7626297F8F8FA6A6A9DD5D5E36D6E9FADAEC97676A49293B7A8A9C6999ABBE3E3ECC2C2D6C5C5D9A6A6C45A5A92AAAAC7A3A3C25E5E95FEFEFE21F90400000000002C00000000140014000005D0E0278EA2830964AA8A9AB749EBEA5CD4636D5C9C12F812202F9DC83218343811430240D0750A8D8211C978C25485578B42511002124520E320513C9A0845E009782410CFA0E0B994E89A0583D0D13C261C0A731E1C09071F191B1D7A2D0D0C330F0150150C0D1E02181B0A061D1E160C13900A0A15130C40641A089D08010F488005120B131D8A230200AD0A340F0C111706131A1B08240E04BF15031C0D08060A121D001D2B05087E9C1ECF0B161A3A7448DA0880420E4615113F1B184223469D1C1065EE22031E1E87F523C8FA2B21003B"


    '*
    '* OS/2
    '* -----------------

    elseif strValue = "os/2" then
        strHex = "47494638396114001400C40000D3D3D3D7DBE9EDEDED0909099696952929299B9B9BCACACBA2A3A7464645B2B2B26B6B6BBBBBBBAAAAAAABB4CF8585855656567C7C7C909090636363DADADAF2F2F2E1E1E1757575DEDEDEE7E7E6FAFAFAC2C2C2E7E9F0C6C6C6F6F6F6FEFEFE21F90400000000002C00000000140014000005EEE0278E64699E221331241704A8B53C025961C071328962060E07C28428005028438122F220499649E7538944249B4F4770388E1013C3837921680890CF43A29844448801B351C014861F406632F15006180203691F1E030B17833E000812190003021B874D05051F0610870A5E0B045A9485965E1D050B151F1206221803132219030909351F05176753154E0997A00D0B0B0C12100A0B05120D133518090F0C100F2214070C811D121710174C1F1409111618160243002C25A81FB1051E07041E0A3E0A3A280B036F083E08530D5E26AD0600D060608307043A18A0334160400101150874F0D080C5390C224200003B"


    '*
    '* RiscOS
    '* -----------------

    elseif strValue = "riscos" then
        strHex = "47494638396114001400C40000131313BABABAC2C2C2E6E6E66A6A6AB6B6B67E7E7EDDDDDDA5A5A5BEBEBE4E4E4E424242838383525252DADADA5F5F5F9595957979799B9B9BABABAB9292925B5B5B7474748F8F8FF5F5F5CECECED5D5D5CACACAD2D2D2C6C6C6666666FEFEFE21F90400000000002C0000000014001400000581E0278E64699E68AAAE6CEBBE3079085B4777B8806F7C5677870427B119240E19CE40A09978188D87C150D81408960E15C161E8289E8587A020043890C78443D12C249E0FE612014C22017CC7828020105612121C0100610F0A0A0C01014C19191A1A451A1D050B0D040B151E15010349A0A11C1C0E91A51A4A31AAABACADAE2321003B"


    '*
    '* Amiga
    '* -----------------

    elseif InStr(strValue, "amiga") > 0 then
		strHex = "47494638396114001400C40000EDD0CEF7FBF6E4B4AFEB7379F59097D3474AD60304ED0404F4E8E2F05552DA7571FAF8EBEF2E34EB3A43C33531D97E85E1908FFCE2DAE88484DB5A5BF6C7BCEF6569D46860F7DAD8F7B7B5F0FEFEEE171EFBF0F1EDA2A0D31A1DFAFEFEFEFEFE21F90400000000002C00000000140014000005FFE0278EE2860401A9AA173708522309DB3A060B91500073548209C6A3F2643E1149658089713E0ACD85386A0138040E20E3C1681A898E2535AA303088CB6543941C0E8D451020F2563699C0353B79378E62220F1A181F1E170410090911140315140B051D6C0B182F2D15090C041E4603060E05055B1918071A09182E0D14861E050706151E1B0119047E011E011C0D0F14171D6F1022000F096F09221E036F7010131D0222081D3B120A00283EB203750E0F22130C5CB10C150D1D061D741F1306E21F181D171FB107130188421B00060C6A18023041410103063064C8602D948502D448403030E002840700221C346001CF8A0D131A6C10807080820E057619D9A8A3C0428701002014782070A58705112E200080A1268910003B"


    '*
    '* BSD
    '* -----------------

    elseif strValue = "openbsd" then
        strHex = "47494638396114001400C40000D5D6D6E6D97AB0AFAF897847E5E6E6F4F4F5A4944E979387DCD3788D876DC3AF5B998B4D6D623EB0A786CBBC66B5AB5BEAE585DEC867BFAB73F1EA86CCC672C0B760D6C970B99F4BF8F28DADA257EBE07EC5C3C2B9B9B8A1A09EF6EE88FEFEFE21F90400000000002C00000000140014000005CBE0278E64699E23819E440B08EA3A16DD71300BD3716BF10E8A482572310C0428C061E1B050348E40E632E8C452374733F0445888834289D0B0209E9089C7135064065731877146403CEA8926714B880003121C0B671A181E1887130807030C621F1B170E0F766A778A1A0A0F0B1B230D119B15080E5E6B1A010B1503707F0B091908190614081E08010117AB093C1F04021D06161A9501B80E0A170C9E63090651665E0A0E030790242D1D0B0B0F0E06CA03BD3D3639390C1C00321F62021B1D0200EAEB222A04D8F4F421003B"

    elseif strValue = "netbsd" then
        strHex = "47494638396114001400C40000939494D7D8D8F36A16F49254FADBC6B4B4B4A8A3A0F4AA7BF9E2D1F6B185E4E4E4F7C4A3F27B32FDF1E9C9CACBEEEDECFAFAFAFCEDE3F7F9FBF9D3BBEEF4F7FDF6EFF8CDB2FDFAF7F25F06F2F2F2F49F68EAC0A5E4CDBDBEC0C1F08745FEFEFE21F90400000000002C00000000140014000005ABE0278E64699E687A4653722CC8452A1B52550D917802735888866C5431088E028CB23778114C0E0F06391D5886A78C713978AA441DCE625251111A9F4944D1F9480281CC4711A0071E9F03E39278522A120001001D050A05000A0601131A1A1316093B08061D8B000E01061F8316151A0C0C91031F060F820A00059B9A0931030309131E0898050501B782860D6522111F0D0F1978731215C42A9A5F288BCC509BCF241082D233C5D65F21003B"

    elseif strValue = "freebsd" then
        strHex = "47494638396114001400C40000EE895BDBA195F77223DD5B50B65554FAC497FBE1D1AD0302C50700A88E8BF9CCC5C9C8C8E7E6E6D41E039205039A7F79B7B6B4FAF9F9E70300E93809F2F2F2D8D7D6A69D99862F2DA4A5A4FDF4F0730505B12B28D33824FFFAF5FCEDDFFFFFFF21F90400000000002C00000000140014000005D9E0278E64699EA8B9408C4855CB525122032D517D0D417233110AA302B104008E8AEB7218184A066744B1B9B4448943E0D3C978339EAD827378E44495C427D331B8DD8AC0E4405890648688A700180C0880081B011024180A061E001312120807070E17170F162416007C8D8D8F0E0E1A1A1716341F11161C138C9C909E9F0E1657A61C0D130D8E9090089F1C2C23180308B408BA0E8F071A0E0518671F100F070DD1BAB8911C06182419161BC1D1D007C11C02B0250B59DD0DA8A9028427CE0DE8EB01D828150F04B3E2000F7629A50B181254C2E1AF608910003B"
    
    elseif InStr(strValue, "bsd") > 0 then
        strHex = "47494638396114001400C40000CB9C78D3C9C6D7CF8EA65D54D0A69DF8F8F764241F9E2B1FBAB9B6271C1AE7D3C5AF99976F7B72CBC3997F5C541F652BEBEBE4444644C53527978F83E4E0BE70631EA64B3DF3F2EBDAD9DADFDFDFEEEEEFEFF1F1BE7E6FF0ECEC63605CFEFEFE21F90400000000002C00000000140014000005B9E0278E5F10901AA98E84039113B292CAE1708EB77C84B1CD22C2C172382412034BE2040C000014CEC1604CBC80088F4300981E99B3C2C0909870245FE087D290480C0349F53783081AD2839CCC00520480000B63641E0540057F02360B7A067D6A223509066E06118791250E8E47749A01066409119A230A6F06151118A6220EA3A429881718080C0FB91E1E110C08199922100A0D13C5B90F98190813CD0B998926141311BD3222010B0B09192B1D1919B31F1D830E132721003B"


    '*
    '* Irix
    '* -----------------

    elseif InStr(strValue, "irix") > 0 then
        strHex = "47494638396114001400C40000F4F0F4664D78847096593668755A877D658FC4BBCDA89BB3B8AAC8CBC4D2A399A7AA99C6E7DFEB6B4B819287ABBBADD9877A9E6E647C6E5381AFA6BA9E95A28F81A2BEB5C7542A649B92B7613E729C8EB6624376C1B3DDA18BAAA591B3FEFEFE21F90400000000002C00000000140014000005DDE0278E64699E68AA960541B4EE5BB445E71D5E8E0C04124086A06020B1B80C8586C533147C2287112340F840028049F5501838A18C0AE2D3FA540209465440F002C003ACA0C0285C3A0040C2E565443A06444601081217120609430D4408110518151510031B671719150E8C8C191011017302439E01171B10109C039E111294120E1B1B188604181A101B8C1B0E12051A030D0BBB080D1710130E0B0D9C0B11020B710F120DD4030B1E051C49441CD03B1BDC1B0F0401DCE70B761701039517EC1987AC6D441219090A14FB140AFAFEFDFEF953306185C18308558400003B"


    '*
    '* HP-UX
    '* -----------------

    elseif InStr(strValue, "hp-ux") > 0 then
        strHex = "47494638396114001400C40000FDE7D6F7730BFEF7F2FDF1E8FCC499FAA766FBBB89F98A34F99C52FCCAA4FCCEA9FDEEE2F77714F88327FAB27AF66600F76A00F76E03F99342F76E06FBB680F99648FDD9BCFAA25EFAAE72F87E22FDDBC0F87E1EF9994EFDE0C9FBB985FEFEFE21F90400000000002C0000000014001400000581E0278E64699E68AAAE6C7B6A962B2EC88399029A044C322A08C120A3F8682A8E8FE0F2B80C469D806471602C3C9046A07098144782CCC17288100A0FCA8779009412904A20B269783F86408063A23C020E0710126E0669160F062503094F0B6E1F040F491F18152C0A0F05321F0013089C000C073932121B4F9C04319CADAE1F21003B"


    '*
    '* Aix
    '* -----------------

    elseif InStr(strValue, "aix") > 0 then
        strHex = "47494638396114001400C40000F1F0F2042486CEB01DED5052C2C9DE5766A7E5050EA70D3358175C218F5B7084B1A7B1D317676C011C8709377F96A5C40E4D778F9BC2766F4DD0DBDEFF4F01CE091C3B476B001480203082BF2729301B75217A67DA828BA1C8B3FC0202FEFEFE21F90400000000002C00000000140014000005BCE0278E23F190682A12D875AA2A7B352E8C4E2D2658D762AF98462320B1087D2AC0A05241382CC6C01089E278AE878040209406082842C663B86A0412C7861108305E1F561951CE08308104A3E1609F080E086401071E143B6E090E10520D0F110D1564079287410E7A6D0117051F1C6557A10743987B9B05001F0357081A0892066D101B09A7A99E03039A0807071A8C108A9D2911339A0C107C091B1330C5428B0E010E0A1DCDCE3342340A3F23904317DCDD230FDBE3280FE22A21003B"


    '*
    '* Java
    '* -----------------

    elseif InStr(strValue, "java") > 0 then
        strHex = "47494638396114001400C40000F4615BF78D88776FCAEAE9F7FAB5B1F6F5FCDAD8F09C96D9FDC9C4FCFAFBB9B5E4CCC8EBF03028FEF6F4FDE3E2A8A3DE8C85D2B3AEE1928CD6A39EDCC2BEE8D5D2EF827ACFF6807BF24841AFAAE0D1CEEEF1F0FA6359C3E0DFF3F8A09CFEFEFE21F90400000000002C00000000140014000005CAE0278E228179897739643B120CD10057E2BA0E137C1770DF304782E1F9E130420CA6616C79761E5DB315407C00BE6961F369103E81E22761A8B42A134A67D4B016061BC34132DA0838938C22F3984C0E130B22051C0324030B0B1A8A1D0336230A028F2203026A0303060B7A090914108624050A1002A60216120A05158237056B532E141CA907A502AE2D050B6A1F681016100F0B5C94361B1C1CC593A20315140A1B9D14B7101207D9DAD90F0A141411052406DF0A117A0AE67C0F14E22D1B031D65151A068DEE2221003B"


    '*
    '* Symbian
    '* -----------------

    elseif strValue = "symbian" then
        strHex = "47494638396114001400C40000E8E8E845454563A3B4F9B82C909090D5D5D5A7A7A72C2C2CB5B5B5C6C6C67A7A7A636363A5C9D4FAE5B4D2E4E9F2F2F2F8F8F8006785FDFDFDF8D686FDFFFFFCF6E891BEC7FFFEFC2C819EE0DFE075AEBEE8F2F2FBFFFFE4EFEFFEFEFEFFFFFF21F90400000000002C00000000140014000005ADE0278E64699EE84951A9E9495553B12DC94DC344D79F473583C62EE5F17C2494CECA0801888C1F00A427F139300E11E21008643E99C0E160288A2C110B980C5004208A05C0B0908C3411CD87A01805120B042312841F0211021F0B06238B095C040F54178789018C22811F050A5C9246951F0A822297231001081F2C787A8F5F5B0FA31F0F7F230C110C22045C07AA5B620B104549021B6605085F461908097645761F1743D3663CD8D9DA3521003B"


    '*
    '* Mobile
    '* -----------------

    elseif strValue = "alcatel mobile" then
        strHex = "47494638396114001400B300006265626F716FB1B2B0898B89E5EDF37C7E7CF2F2F2E5E5E5A4A5A3484B47FEFEFE55585400000000000000000000000021F90400000000002C000000001400140000045370C949ABBD38EB3D4749DC940487008612A21CC1B925C0A12888BBA9336B5FB031CF350EEEA7D30008BF5F109318268B16982CA9640AA84FC06E11C32611D1AB97A8A5240688B47A9D064413F0B83C8EAAA322003B"

    elseif strValue = "sonyericsson mobile" then
        strHex = "47494638396114001400C4000095A1A2035C286A9B86CCCDD24E9579F7F6FAE6E7E80590475E6A70B2DCB005A34F91C98F286C403FB37417B3663C885EE8F3EC6CC186BBCCC2EDEDF1A8DA9CF0F2F4027A3A6D7C7AE1E3E5B3B5BBDADBDEDDE9DAFEEEFA034915838E93FEFEFE21F90400000000002C00000000140014000005F6E0278E64419E685161583555263A5603F0300CE0BEF267780C41A0D361405406436C64B874029145E31029142093E40910B044128948E468AD183086D1E041DD40288B8DB5309914309A58E6E15880131B1C0512020C0F031303187400020D51121A1C18110A16440C12031A1318021E0000190303090E0A071601AB04A41A18040E02A1110D0AA8AAAB160F19911502B70AA7B7A9ABBA04008A1F00079607CF16B9C60AB303266B0E075DC6DC070DA013231E0F110F4444C607B21E19241A08027037D116C20417004B22EF1712090B114E3DB88000403814183C204070E1C283851732E843A10100C10BEC30F438414703A71E2100003B"

    elseif strValue = "nokia mobile" then
        strHex = "47494638396114001400C40000758EE2355AD4F9FAFEBCC9F18CA1E7D5DDF6849AE5A4B5EB94AAE8DDE4F87C92E16785DF9CB2E9B4C3EE446BD8AEBCEF0028C8173CCE1946CF5B7ADD3B61D6224FD0EFF3FB90A6E86E87E02951D3EBEFFACFD9F40F3ECCC4D0F2C8D4F3FFFFFF21F90400000000002C0000000014001400000558E0278E64699E68AAAE6CEBBE707C26CAF61D1D80191EF3210D86C5A2287C1E11492210C03C26948A6362E124004CC101408864028A01543AD1481010070451687C0886016601185CDE8CCBE5501810648081828384852D21003B"

    elseif strValue = "motorola mobile" then
        strHex = "47494638396114001400C400007D8E9B8F9DA9C2CBD3B5C2CEDBE2E8ECEEF24F6475ADBAC698A5B1607483B1BECBBBC6D1E2E6EBFBFBFCEFF2F5D7DEE5A6B5C3F6F6F8E6EAEEF3F5F6D2DAE2BECAD5C9D2DCCDD6DEA3AEB8AAB7C36F8290F9FAFAD9DFE7C6CFD8F2F2F4FEFEFE21F90400000000002C00000000140014000005FFE0278E62E4144E44AE64E349CF655997C4AE9BC770D45C2D97C6AA3111460AB09EE0A7E8AC0A0521455178502A88CE6270B88C0A9C820803A83E0E89DF4071707C1A9C87F8034810088F80215359432C1F0E17611F050906030C141A0601026B070A0D1216046202068D120B991A5B6C191304161C6E7A061A04189909070B6C100E0C950E1E091A00060B75B901AF07103AA41102001B1F64001D17089E5C191B0EC308141F2F0007141D1D00100A190B6F141C04010D3912CB16DB080803100422050417031FE8043D1D0207010703424430B0F1468795756A32CCF9722C1A8318331E1D60702382451D3C2C3C5AB090053E191D2C3008788384C508C76E028400003B"


    '*
    '* Unix
    '*
    '* @todo
    '* -----------------

    elseif strValue = "unix" then
        strHex = ASG_STR_ICON_HEX_BLANK


    '*
    '* Robot
    '* -----------------

    elseif strValue = "robot" then
        strHex = "47494638396114001400C40000F6F6F6A7A3A3E5E5E5EDECEBC7C7C6B7BABA9999976654508B878552483A7870719DA19CDFDFDE53504ED4D0D02F2A29433B3792938FC0BCBAB7B0ADCFD1CDBDC1BFA59C9AEDEFEFB1B0B1958785725F59E8E8E7F1F1F1DCD6D7D9D8D8FFFFFF21F90400000000002C0000000014001400000574E0278E64699E68AAAE6CEB7E4020BCDCB749132632438A05154946A3F8541488CE4950F82C2090840671684410041363B3301812E0C7E140B8289424CF22FB3134208F86C2E018483C244E4D24301C160B0D13331F84280058140A3D2E16171F017B2D110C6D8C2D157801972F1B2F9FA0A11F21003B"


    '*
    '* Debug
    '* -----------------

    elseif strValue = "debugicon" then

        ' get debug URI
        ' get list of icons per page
        ' check whether list of icons per page has been sent
        ' send list of icons per page
        ' unset list of icons per page


    '*
    '* Invalid matching
    '* -----------------

    else
        strHex = ASG_STR_ICON_HEX_UNKNOWN_OS
        ' store values into a temporary cache for debug
        Session("strAsgIconOs") = Session("strAsgIconOs") & strValue & "|"
	
    end if

    getOsIconHex = strHex

end function 


'/**
' * Prints a binary icon from its Hex representation
' * 
' * @param  string  strIconHex
' * @return void
' */
public function printIconFromHex(strIconHex)
    ' Requirements: only gif images are allowed 
    Response.ContentType = "image/gif"
    ' Convert
    for ii = 1 to Len(strIconHex) step 2
        Response.BinaryWrite(ChrB("&h" & Mid(strIconHex, ii, 2)))
    next
end function 

' Execute
strHex = getOsIconHex(Request.QueryString("icon"))
printIconFromHex(strHex)

%>