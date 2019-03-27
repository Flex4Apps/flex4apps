Flex4apps
=========

This is the main git repository for the [ITEA3](https://itea3.org/) [Flex4Apps project](https://itea3.org/community/project/flex4apps/basics.html).
More information can be found on the [website](https://www.flex4apps-itea3.org/)

All the documentation and howto guides in this repository can be best read at [f4a.readthedocs.io](https://f4a.readthedocs.io/en/latest/?badge=latest).

Build status
------------

[![Documentation Status](https://readthedocs.org/projects/f4a/badge/?version=latest)](https://f4a.readthedocs.io/en/latest/?badge=latest)


Building the docs locally
----------------

execute the following command in the base directory of the repository ...

   docker run --name buildTheDocs --rm \
      -e "Project=Flex4apps" \
      -e "Author=Till Witt, Johannes Berg, Alex Nowak" \
      -e "Version=v0.1" \
      -v "$(pwd)/compose:/project/compose" \
      -v "$(pwd)/docs:/project/input" \
      -v "$(pwd)/output:/project/output" \
      -i -t tlwt/sphinxneeds-docker
