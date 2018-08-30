Flex4apps
=========

the project documentation can be found at:

* https://documentation.f4a.me
* or as PDF: https://gogs.tillwitt.de/NXP/flex4apps/src/master/output/pdf/Flex4apps.pdf


Updating the doc
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
