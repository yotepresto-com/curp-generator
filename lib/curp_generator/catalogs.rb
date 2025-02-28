# rubocop:disable Metrics/ModuleLength
module CurpGenerator
  module Catalogs
    STATES = {
      'AGUASCALIENTES'        => 'AS',
      'AG'                    => 'AS',
      'AGU'                   => 'AS',
      'BAJA CALIFORNIA NORTE' => 'BC',
      'BC'                    => 'BC',
      'BCN'                   => 'BC',
      'BAJA CALIFORNIA SUR'   => 'BS',
      'BS'                    => 'BS',
      'BCS'                   => 'BS',
      'CAMPECHE'              => 'CC',
      'CM'                    => 'CC',
      'CAM'                   => 'CC',
      'CHIAPAS'               => 'CS',
      'CS'                    => 'CS',
      'CHP'                   => 'CS',
      'CHIHUAHUA'             => 'CH',
      'CH'                    => 'CH',
      'CHH'                   => 'CH',
      'COAHUILA'              => 'CL',
      'CO'                    => 'CL',
      'COA'                   => 'CL',
      'COLIMA'                => 'CM',
      'CL'                    => 'CM',
      'COL'                   => 'CM',
      'CIUDAD DE MEXICO'      => 'DF',
      'DF'                    => 'DF',
      'CMX'                   => 'DF',
      'CDMX'                  => 'DF',
      'DURANGO'               => 'DG',
      'DG'                    => 'DG',
      'DUR'                   => 'DG',
      'GUANAJUATO'            => 'GT',
      'GT'                    => 'GT',
      'GUA'                   => 'GT',
      'GUERRERO'              => 'GR',
      'GR'                    => 'GR',
      'GRO'                   => 'GR',
      'HIDALGO'               => 'HG',
      'HG'                    => 'HG',
      'HID'                   => 'HG',
      'JALISCO'               => 'JC',
      'JA'                    => 'JC',
      'JAL'                   => 'JC',
      'MEXICO'                => 'MC',
      'EM'                    => 'MC',
      'MEX'                   => 'MC',
      'ESTADO DE MEXICO'      => 'MC',
      'MICHOACAN'             => 'MN',
      'MI'                    => 'MN',
      'MIC'                   => 'MN',
      'MORELOS'               => 'MS',
      'MO'                    => 'MS',
      'MOR'                   => 'MS',
      'NAYARIT'               => 'NT',
      'NA'                    => 'NT',
      'NAY'                   => 'NT',
      'NUEVO LEON'            => 'NL',
      'NL'                    => 'NL',
      'NLE'                   => 'NL',
      'OAXACA'                => 'OC',
      'OA'                    => 'OC',
      'OAX'                   => 'OC',
      'PUEBLA'                => 'PL',
      'PU'                    => 'PL',
      'PUE'                   => 'PL',
      'QUERETARO'             => 'QT',
      'QT'                    => 'QT',
      'QUE'                   => 'QT',
      'QUINTANA ROO'          => 'QR',
      'QR'                    => 'QR',
      'ROO'                   => 'QR',
      'SAN LUIS POTOSI'       => 'SP',
      'SL'                    => 'SP',
      'SLP'                   => 'SP',
      'SINALOA'               => 'SL',
      'SI'                    => 'SL',
      'SIN'                   => 'SL',
      'SONORA'                => 'SR',
      'SO'                    => 'SR',
      'SON'                   => 'SR',
      'TABASCO'               => 'TC',
      'TB'                    => 'TC',
      'TAB'                   => 'TC',
      'TAMAULIPAS'            => 'TS',
      'TM'                    => 'TS',
      'TAM'                   => 'TS',
      'TLAXCALA'              => 'TL',
      'TL'                    => 'TL',
      'TLA'                   => 'TL',
      'VERACRUZ'              => 'VZ',
      'VE'                    => 'VZ',
      'VER'                   => 'VZ',
      'YUCATAN'               => 'YN',
      'YU'                    => 'YN',
      'YUC'                   => 'YN',
      'ZACATECAS'             => 'ZS',
      'ZA'                    => 'ZS',
      'ZAC'                   => 'ZS',
      'EXTRANJERO'            => 'NE',
      'NE'                    => 'NE',
      'FOREIGN'               => 'NE'
    }.freeze

    FORBIDDEN_WORDS = {
      'BACA' => 'BXCA',
      'LOCO' => 'LXCO',
      'BAKA' => 'BXKA',
      'BUEI' => 'BXEI',
      'BUEY' => 'BXEY',
      'CACA' => 'CXCA',
      'CACO' => 'CXCO',
      'CAGA' => 'CXGA',
      'CAGO' => 'CXGO',
      'CAKA' => 'CXKA',
      'CAKO' => 'CXKO',
      'COGE' => 'CXGE',
      'COGI' => 'CXGI',
      'COJA' => 'CXJA',
      'COJE' => 'CXJE',
      'COJI' => 'CXJI',
      'COJO' => 'CXJO',
      'COLA' => 'CXLA',
      'CULO' => 'CXLO',
      'FALO' => 'FXLO',
      'FETO' => 'FXTO',
      'GETA' => 'GXTA',
      'GUEI' => 'GXEI',
      'GUEY' => 'GXEY',
      'JETA' => 'JXTA',
      'JOTO' => 'JXTO',
      'KACA' => 'KXCA',
      'KACO' => 'KXCO',
      'KAGA' => 'KXGA',
      'KAGO' => 'KXGO',
      'KAKA' => 'KXKA',
      'KAKO' => 'KXKO',
      'KOGE' => 'KXGE',
      'KOGI' => 'KXGI',
      'KOJA' => 'KXJA',
      'KOJE' => 'KXJE',
      'KOJI' => 'KXJI',
      'KOJO' => 'KXJO',
      'KOLA' => 'KXLA',
      'KULO' => 'KXLO',
      'LILO' => 'LXLO',
      'LOKA' => 'LXKA',
      'LOKO' => 'LXKO',
      'MAME' => 'MXME',
      'MAMO' => 'MXMO',
      'MEAR' => 'MXAR',
      'MEAS' => 'MXAS',
      'MEON' => 'MXON',
      'MIAR' => 'MXAR',
      'MION' => 'MXON',
      'MOCO' => 'MXCO',
      'MOKO' => 'MXKO',
      'MULA' => 'MXLA',
      'MULO' => 'MXLO',
      'NACA' => 'NXCA',
      'NACO' => 'NXCO',
      'PEDA' => 'PXDA',
      'PEDO' => 'PXDO',
      'PENE' => 'PXNE',
      'PIPI' => 'PXPI',
      'PITO' => 'PXTO',
      'POPO' => 'PXPO',
      'PUTA' => 'PXTA',
      'PUTO' => 'PXTO',
      'QULO' => 'QXLO',
      'RATA' => 'RXTA',
      'ROBA' => 'RXBA',
      'ROBE' => 'RXBE',
      'ROBO' => 'RXBO',
      'RUIN' => 'RXIN',
      'SENO' => 'SXNO',
      'TETA' => 'TXTA',
      'VACA' => 'VXCA',
      'VAGA' => 'VXGA',
      'VAGO' => 'VXGO',
      'VAKA' => 'VXKA',
      'VUEI' => 'VXEI',
      'VUEY' => 'VXEY',
      'WUEI' => 'WXEI',
      'WUEY' => 'WXEY'
    }.freeze

    COMMON_NAMES = [
      'MARIA DEL',
      'MARIA DE LOS',
      'MARIA',
      'JOSE DE',
      'JOSE',
      'MA.',
      'MA',
      'M.',
      'J.',
      'J'
    ].freeze

    COMPOSED_NAMES = [
      'DA ',
      'DAS ',
      'DE ',
      'DEL ',
      'DER ',
      'DI ',
      'DIE ',
      'DD ',
      'EL ',
      'LA ',
      'LOS ',
      'LAS ',
      'LE ',
      'LES ',
      'MAC ',
      'MC ',
      'VAN ',
      'VON ',
      'Y '
    ].freeze
  end
end
# rubocop:enable Metrics/ModuleLength
