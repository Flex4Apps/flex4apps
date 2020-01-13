Best practices
##############

Log file analysis
=================

The importance of logs
----------------------

In today's software industry, monolithic architectures are more and more replaced by smaller, distributed services. Paradigms such as cloud computing and microservices are central to this development.

While small programs providing one or a few well defined services are easy to understand in isolation, real-life systems often comprise a multitude of such programs, resulting in a high level of complexity and possibly unforeseen problems. The hardest part of fixing issues in such a system often consists of reconstructing the exact interactions and conditions under which the issue occurred. Logging often is the only way by which this information can be made available. But log files do not only provide crucial information for problem-solving in distributed systems; they additionally are a data source from which valuable business insights can be obtained.

Modern large-scale web services often produce vast amounts of logs, which makes manual inspection and analysis unfeasible. Automated analysis techniques such as machine learning can be applied to solve this problem. Cheap storage to save the logs and cheap computing power to analyse them are both available.

In this use case, tools to analyse unstructured log files are developed with the goal of creating an automated anomaly detection system. In this context, *anomaly* is defined as any irregular behaviour of the system on which the logs are produced, including software bugs and hardware failures. The real-life log files analysed within Flex4Apps are unstructured and produced by software running on complex telecommunication infrastructure elements.

Log Templater - A tool for log conversion
-----------------------------------------
Central to our log analysis is *Log Templater*, a tool we developed to convert unstructured logs into structured (terminology is explained below) ones. We intend to make this tool open source. A link to the code will be published here.

How to format logs
------------------

The aim of the following guidelines on how to log is to facilitate analysis of the logging data, with a focus on automated analysis methods

**Write structured log messages.**
  Unstructured logs usually have a format similar to the following:

  ``[timestamp] [severity] [process_name] log_message``

  The log message itself consists of a simple, unstructured string, for example

  ``Failed login for user f4a (invalid password)``

  An equivalent structured message in JSON format is

  ``{“message type”: “failed login”, “parameters”: {“user”: “f4a”, “reason”: “invalid password”}}``

  For a human, an unstructured message is easy to interpret, but automatically extracting information from it is problematic. In the above unstructured example, a log parser would need to detect ``Failed login`` as the category or type of the message, ``f4a`` as the user and ``invalid password`` as the reason for the failed login. The information that ``invalid password`` is a reason for the failed login is not even explicitly present in the message. Treating a log message as a set of key-value pairs ensures that for every value present in the message, there exists a corresponding key or identifier, thus parsing information for subsequent analysis is made easy.

  An additional advantage of structured logs is that adding information to existing log statements in the source code will not break existing analysis scripts, since these scripts will rely on key-value pairs and not on the exact order of words in the message.

  A central component developed within the log analysis part of Flex4Apps is a log converter which is able to identify parameters in unstructured log messages and subsequently convert these messages to structured messages. Today, this feature is essential to perform analyses on a large variety of logs, since currently, unstructured log messages are still the norm. Documentation for this converter is available `here <https://github.com/Flex4Apps/flex4apps/blob/master/docs/chapter02_stateOfTheArt/LogAno_manual.pdf>`_.
  
**Use a single structured format throughout all parts of the application.**
  Otherwise, parsing logs from your application will only get more complicated.

**Provide event IDs.**
  Each source code statement producing a log entry should print a unique log ID. This makes filtering for specific messages or events easy.

**Ensure consistency of key names.**
  For entities which exist at different locations in the log-producing system, such as users, hosts, or session IDs, use the same key name in different message types. Do not use ``user`` for ``failed login`` and ``username`` for ``requesting password change``, but keep the key consistent by choosing ``user`` in both cases. Consistent keys allow for easy tracking of entities throughout the system by filtering for all log messages containing entries such as ``{“user”: “f4a”}``. A central dictionary of existing key names which is accessible and modifiable by all developers may help to ensure consistency.

**Make it easy to distinguish between events happening at different points in the system, but at the same time.**
  This can be done by adding entries for hosts, processes, threads, etc. to log messages.

**Provide as much context as possible.**
  Treat each log message as a message about an event. All context necessary to understand the event should be present in the log message. Long log messages with many parameters are not an issue if they are well-structured, allowing for easy filtering of information relevant to the current analysis. Logging the class and function in which the event took place may be helpful.

  At the time of development, most likely you will not be able to think of all possible questions someone might want to answer with the help of the log files written by your application. Consequently, providing as much information as possible may prove helpful in the future.

**Severity levels have limited use in complex systems.**
  An upstream event may not be critical for the component in which it takes place, but may cause problems in a component further downstream. The downstream component may not be known to the developer of the upstream component, so choosing appropriate severity levels for all situations is not possible.

**Use fine-grained timestamps with time zones.**
  A granularity of at least milliseconds ensures the correct order of events happening in fast succession can be reconstructed. Time zone information is essential in distributed systems where individual components may be located on different continents.

Analytics in cloud solutions and software as a service (SaaS)
=============================================================

Since the SaaS and Cloud paradigms leverage the Internet as a distribution channel, SaaS offers software builders the possibility to offer their products and service on a global scale. Most SaaS business models are based on a “pay-as-you-go” principle, whereby customers pay a monthly fee based upon their usage of the product (i.e. number of users, storage, ...). It is fairly well understood which high level KPIs matter most for SaaS businesses; most notably acquisition cost (the cost to attract a new customers), lifetime value (the total revenue generated per customer over the life span of the relationship with the customer) and month over month growth. It is considered a best practice to deploy dashboards to monitor these high level KPIs. A growing number of SaaS products become available offering such dashboards as a service. 

The role of product management in a SaaS business is to design “a system” by combining technologies into a total UX so that business goals are achieved. In this context, UX involves all touch points between company and customers (i.e. marketing material, product itself, pricing and price plans, support,) and includes both product design and interaction design. 

Designing a successful user experience for any product is a wicked problem. I.e. there are only better and worse solutions, and only by experimentation, iteration, monitoring and validation one can determine if one is moving towards a better solution or away from it. This in itself is nothing new: in the software world, agile software development popularized the idea of incremental iterations and timely feedback. The Lean Startup movement applied a similar reasoning to not just product development, but to the entire process of business development and go-to-market, while more recently the growth hacking community applies a similar reasoning to marketing. 

While the statement designing a successful user experience is wicked problem is true for most products (hardware or software, B2C or B2B), online businesses, and thus Cloud/SaaS businesses have a clear advantage: they can iterate and experiment very fast: indeed, deploying a new version of the product is often just a matter of minutes, thanks to advances in DevOps. SaaS providers have the possibility to monitor and measure the impact of a change instantly, via monitoring and analytics, and treat their entire operations (i.e. product, service, user base, etc.) as “a living lab“. Some well-known examples of companies doing this are Netflix.com, Google.com, or the Huffington Post with their A/B testing of headlines. 

In a SaaS context, and in general, for companies that want to use the “too cheap to meter” strategy to deal with the software paradox, the discipline of Product Management is dramatically changing and broadening. A SaaS product manager is not only responsible for defining the product’s features and how to support these, she has to incorporate valorization and growth strategies as well. She will leverage the possibilities of instant change (DevOps) and instant feedback (metrics and analytics) and install a living lab throughout the entire SaaS operation. 

In order to be successful at installing this living lab, software product managers for SaaS products will want to use analytics and usage data to make informed product management decisions, as well as install feedback loops that potentially expand to all stakeholders so that the information collected via the analytics can be leveraged throughout the entire SaaS organization.  

Analytics best practices
------------------------

When talking about data-driven product and growth management (often in an online SaaS content), it is more common to talk about analytics than to talk about logging, although conceptually, these are similar, in the sense that instead of logging information about how the system is behaving, one logs information on how the user is behaving on the system. So many of the best practices described above, apply for this use case as well. Specifically naming conventions: the naming of the events is important, once a specific user event (e.g. user presses the submit button of the “create project” form) is given a name, one shouldn’t go lightly on changing the name of this event, since that might skew reporting later on.  

**Use structured formats (e.g. JSON, protobuffers).**
  For analytics event reporting, JSON is the most widely used format to serialize and transport the data. JSON is easy to read and write from within JavaScript, the most used front end language for digital services. Virtually every programming language has extensive support to parse and generate JSON documents. Moreover, many database systems (both SQL and NoSQL based) support JSON as a data type and allow querying within JSON data structures. 

**Consider front end and back end analytics.**
  Many analytics are gathered on the client side, and then sent back to the analytics back end This is logical and easiest, since it is with the client side (web app, mobile, …) that the user interacts. The downside of this approach is that, depending on what analytics technology is used, the user might block communication between client and analytics back end (e.g. though the use of ad blockers, ad blocking proxies, etc…). When you want to be absolutely certain to track certain events within your analytics system, consider logging these events from the server side (a user has no control over what happens on the server side). 

**Minimal structure of an analytics log message**
  At a minimum, each analytics event message should have:
  
  - A user ID: this is a unique identifier for the given user. This can be the same ID as the user is known in the actual system, like a guid or an email address.
  - A time stamp when the event happened, preferable in UTC.  
  - The name of the event.  
  - Optionally, one can provide additional meta data that might be relevant for the given event. Meta data could be details on the users client (browser, OS, …), metrics (e.g. for an event “watch_movie”, the meta data could contain which move and the percentage of the video the user watched) or any other info that seems relevant. 

**Consider sending event data in batches.**
  Depending on how much analytics you gather (e.g. you only record major events in the app vs. you record every single click a user does), one might consider batching the event data and send over multiple events at once, every x seconds, instead of sending the events over as soon as they happen. Especially for mobile apps, consider the offline case, whereby analytics are batched and cached when the client is used offline. 

**Use analytics to build user profiles.**
  A user profile for this case indicates, for every single user, the activity that user expressed with the application. Based upon that data, one can derive the type of user (e.g. a project manager vs a project contributor, …) , how engaged he/she is with the service (power user vs. novice trial user), latest activity, etc. In it’s simplest form, this user profile is a timeline of all the events the user did on the system. 

**Build dashboards/queries to follow up on major KPIs.**
  Gathering the analytics data is one thing, putting them to good use is another one. At the very least, build some dashboards that illustrate the major KPIs for the SaaS business. At least have a dashboard that illustrates the evolution of new accounts/unit of time, churn rates over time, breakdown of feature usage, funnel metrics and engagement metrics. 

**Feed back analytics data to all stakeholders.**
  Dashboards are one way of feeding back the data and information to stakeholders, but there are other possibilities as well: 

  - Connect the user profiles with support systems, so that, whenever support questions come in, the support agent has the context of the given user (e.g. engagement level, the plan the user is one, …) at her fingertips and thus can give tailored support (microcare) 

  - Feed back the analytics (or parts thereof) to the end users: e.g. as reporting on how all users within an organization are using the SAAS. These can be in the form of reports, dashboards … 

  - Sales and account management: having a clear insight on the usage patterns of a given customer/account, the sales or account management organization can discuss potential opportunities to up sell/cross sell. 

Business best practices
-----------------------

-	Discuss and identify a feedback loop. Product managers and stakeholders can use the data to focus on important topics but will have to consciously look at the data and interpret it to form good decisions.

-	Make sure to invest time in generating reports, spreadsheets or other forms of data that is usable by business users who actually want the data. If the form is not accessible enough it will not be used.

-	Design for flexibility. As soon as data is available, new questions will arise which potentially need extra data to be gathered.

-	Think about security and Data Protection. GDPR can have a significant impact if you collect data that might be identifiable.

-	Think about the lifetime of the analytics. Storing everything forever might be a good idea but more often than not the value decreases rapidly. Make sure to pass this to the technical process.

Technical best practices
------------------------

- **In cloud solutions, stateful deployments need the most attention.**
  
  Before starting Flex4Apps, project partners believed that managing fail-over scenarios for high-availability installations is the part which is most difficult to handle.

  During learning about cluster deployment, we realized various solutions exist for stateless services. Tasks become complicated if services need persistence (so-called stateful services).

  Storage has to be provided as an extra high-availability service, which makes it cost intensive. An alternative approach is to look for storage software which inherits support for multi-node cluster deployment. This can mean that a vendor lock-in can't be avoided. 

- **S3 can be a good light cloud storage.**

  There is no vendor lock-in, because various implementations at commercial clouds exist next to various open source implementations. S3 can be deployed on small single nodes or on clusters with redundancy for high availability. However, S3 is only suited for pure storage, not for complex querying.

  If S3 is not good enough, there is no one-size-fits-all solution out there right now. Most secure and usable solutions are bound to a cloud provider. Check costs and functions of storage and for other needed functions of the cloud provider.
-	Be aware of the cost factors of the chosen solution and see where the dominant factors lie as volumes increase.

-	Compress close at the source (and try and match optimal parameters) because transmission costs can otherwise be very high.

-	Filter data (preferably dynamically) at the source to keep storage and analytics persistency costs down.

-	Unpredictable traffic surges might overwhelm your end-points. Also make sure to keep in mind where your clients are sending the data. Don't reinvent the wheel. Sending directly to AWS Kinesis Firehose will handle any load but requires AWS credentials.

-	Define if and what *real-time* means for your use case. If the real time can work asynchronously and tolerate delays you can design the system to be very cost efficient.

-	Don't try and find the ideal storage solution as there is none that is fully cross platform and portable across all cloud vendors unless you sacrifice features (dropping down to standard SQL instead of NoSQL, Big Data or analytic systems). Mix and match storage solutions as you see fit.

Home automation
===============

Measured values from the residential area of tenants or house owners are to be automatically made available in third-party software. This increases the comfort of use. The user receives more information as a basis for decision-making on his supply contracts and consumption behaviour.
 
To implement this connection, the user employs a gateway that collects the measured values and transmits them via a defined interface to a platform derived from Flex4Apps components.

Best practices
--------------

**Prefer industry standard over individual.**
  Use-case home automation is characterized by a multitude of manufacturer-specific and self-contained solutions. In the course of the project it became clear that trust in such an individual standard can be disappointed. 

  Only through the consistent use of open interfaces and basic products can the dependency on individual providers and their business models be avoided. This enables solutions which work better in a very volatile environment and which can be quickly adapted to new circumstances.

**Consider the overhead caused by addressing and encryption. Limited bandwidth can limit use case.**
  Standard encryption procedures produce a little data overhead. This can be too much depending on the available throughput to the used media.

  This became relevant in the attempt to set up in-house communication on an existing proprietary system solution. While the transmission of user data was just possible, encryption of this data was too much for the medium.

  When estimating the required transmission capacity, it is therefore essential to consider the overhead caused by addressing and encryption.

**Use MQTT as central transport layer.**
  MQTT is widely used and accepted as a vendor-neutral transmission protocol. Consequently, employing MQTT enables the quick integration of new data sources from third parties.

