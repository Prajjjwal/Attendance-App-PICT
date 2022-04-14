import 'package:pict_mis/Subjects.dart';

var SE_even = {
  'TH': [
    'Engineering Mathematics III (EM3)',
    'Data Structure and Algorithms (DSA)',
    'Software Engineering (SE)',
    'Microprocessor (MP)',
    'Principles of Programming Languages (PPL)'
  ],
  'PR': [
    'Data Structure and Algorithms Laboratary (DSAL)',
    'Microprocessor Laboratary (MPL)',
    'Engineering Mathermatics Tutorial (TUT)',
    'Code of Conduct (COC)'
  ]
};

var SE = {
  'Engineering Mathematics III (EM3)': 'TH',
  'Data Structure and Algorithms (DSA)': 'TH',
  'Software Engineering (SE)': 'TH',
  'Microprocessor (MP)': 'TH',
  'Principles of Programming Languages (PPL)': 'TH',
  'Data Structure and Algorithms Laboratary (DSAL)': 'PR',
  'Microprocessor Laboratary (MPL)': 'PR',
  'Engineering Mathermatics Tutorial (TUT)': 'PR',
  'Code of Conduct (COC)': 'PR'
};

var batch_th = [
  'FE-1',
  'FE-2',
  'FE-3',
  'FE-4',
  'SE-1',
  'SE-2',
  'SE-3',
  'SE-4',
  'TE-1',
  'TE-2',
  'TE-3',
  'TE-4',
  'BE-1',
  'BE-2',
  'BE-3',
  'BE-4'
];
var batch_pr = [
  'E-1',
  'F-1',
  'G-1',
  'H-1',
  'E-2',
  'F-2',
  'G-2',
  'H-2',
  'E-3',
  'F-3',
  'G-3',
  'H-3',
  'E-4',
  'F-4',
  'G-4',
  'H-4',
];

var SE_odd = {
  'TH': ['ABC', 'XYZ'],
  'PR': ['ABC', 'XYZ']
};

var TE_even = {
  'TH': ['ABC', 'XYZ'],
  'PR': ['ABC', 'XYZ']
};

var TE_odd = {
  'TH': ['ABC', 'XYZ'],
  'PR': ['ABC', 'XYZ']
};

var BE_even = {
  'TH': ['ABC', 'XYZ'],
  'PR': ['ABC', 'XYZ']
};

var BE_odd = {
  'TH': ['ABC', 'XYZ'],
  'PR': ['ABC', 'XYZ']
};

subjectsDropDown(Subjects s) {
  List item = [];
  if (s.year == 'SE') {
    SE_even.forEach((key, value) {
      for (var i in value) {
        item.add(i);
      }
    });
  } else if (s.year == 'TE') {
    TE_even.forEach((key, value) {
      for (var i in value) {
        item.add(i);
      }
    });
  } else {
    BE_even.forEach((key, value) {
      for (var i in value) {
        item.add(i);
      }
    });
  }

  return item;
}

BatchDropDown(Subjects s) {
  List item = [];
  if (s.year == 'SE') {
    if (SE[s.subject] == 'TH') {
      return batch_th.sublist(4, 8);
    } else {
      return batch_pr;
    }
  }
}

// var classes = {
//   'SE': {
//     'Even': {
//       'TH': [
//         'Engineering Mathematics III (EM3)',
//         'Data Structure and Algorithms (DSA)',
//         'Software Engineering (SE)',
//         'Microprocessor (MP)',
//         'Principles of Programming Languages (PPL)'
//       ],
//       'PR': [
//         'Data Structure and Algorithms Laboratary (DSAL)',
//         'Microprocessor Laboratary (MPL)',
//         'Engineering Mathermatics Tutorial (TUT)',
//         'Code of Conduct (COC)'
//       ]
//     },
//     'Odd': {'ABC': 'TH', 'XYZ': 'PR'}
//   },
//   'TE': {
//     'Even': {'ABC': 'TH', 'XYZ': 'PR'},
//     'Odd': {'ABC': 'TH', 'XYZ': 'PR'}
//   },
//   'BE': {
//     'Even': {'ABC': 'TH', 'XYZ': 'PR'},
//     'Odd': {'ABC': 'TH', 'XYZ': 'PR'}
//   },
// };