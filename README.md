Flex4apps
=========

the documentation can be found at readthedocs:

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
