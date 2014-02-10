window.onload = function() {
  var comments = [
    {
      id: 'a532',
      author: 'Ishmael',
      body: 'This is a comment.',
      date: new Date(),
      replies: [
        {
          id: 'b54',
          author: 'Pops',
          body: 'Wow. What a great comment.',
          date: new Date(),
          replies: []
        }
      ]
    },
    {
      id: 'y43',
      author: 'Rabblerouser',
      body: 'rabble rabble rabble',
      replies: []
    },
    {
      id: 'f99',
      author: 'Steven',
      body: 'Bow down, mortals.',
      replies: [
        {
          id: '5ts',
          author: 'Ishmael',
          body: 'no u',
          date: new Date(),
          replies: [
            {
              id: 's84s',
              author: 'Steven',
              body: 'no u',
              date: new Date(),
              replies: []
            }
          ]
        },
        {
          id: 'k90',
          author: 'Pops',
          body: 'Go to your room.',
          date: new Date(),
          replies: []
        }
      ]
    },
    {
      id: 'la35',
      author: 'Ma',
      body: 'I hate all of you.',
      replies: []
    },
  ]

  var lolita = new Lolita('#target', {
    comments: comments
  });
}